#include "../../includes/channels.h"
#include "../../includes/packet.h"
#include "../../includes/protocol.h"

module FloodingP {
	provides interface Flooding;
	uses interface SimpleSend as simpleSend;
	uses interface Hashmap<uint32_t> as PreviousPackets;
}
implementation {
	pack sendPackage;
	uint16_t sequenceNum = 0;

	void makePack(pack *Package, uint16_t src, uint16_t dest, uint16_t TTL, uint16_t protocol, uint16_t seq, uint8_t* payload, uint8_t length) {
        Package->src = src;
        Package->dest = dest;
        Package->TTL = TTL;
        Package->seq = seq;
        Package->protocol = protocol;
        memcpy(Package->payload, payload, length);
    }

    bool containsval(uint32_t key, uint32_t val) {
    	if(call PreviousPackets.contains(key)) {
    		if(call PreviousPackets.get(key) == val) {
    			return TRUE;
    		}
    	}
    }

    command void Flooding.ping(uint16_t destination, uint8_t *payload) {
        dbg(FLOODING_CHANNEL, "PING EVENT \n");
        dbg(FLOODING_CHANNEL, "SENDER %d\n", TOS_NODE_ID);
        dbg(FLOODING_CHANNEL, "DEST %d\n", destination);
        makePack(&sendPackage, TOS_NODE_ID, destination, 22, PROTOCOL_PING, sequenceNum, payload, PACKET_MAX_PAYLOAD_SIZE);
        call simpleSend.send(sendPackage, AM_BROADCAST_ADDR);
        sequenceNum++;
    }

    command void Flooding.Flood(pack* letter){                                 // Letter is the same as "packet"
        if(containsval(letter -> seq, letter -> src)){
            dbg(FLOODING_CHANNEL, "Duplicate packet. Will not forward...\n");           //Debugging Message PRint
        } else if(letter -> TTL == 0) {                                                 //When the packet's time to live has expired we don't forward
            dbg(FLOODING_CHANNEL, "Packet has expired. Will not forward to prevent infinite loop...\n");
        } else if(letter -> dest ==  TOS_NODE_ID){
            if(letter -> protocol == PROTOCOL_PING){                                    //inplementing HANDLE PAYLOAD RECEIVED
                dbg(FLOODING_CHANNEL, "Package has reached the destination!...\n");

                call PreviousPackets.insert(letter -> seq, letter -> src);           //Keeping track of the source of our pakets and it's respective sequence
                makePack(&sendPackage, letter -> dest, letter -> src, 10, PROTOCOL_PINGREPLY, sequenceNum++, (uint8_t *) letter -> payload, PACKET_MAX_PAYLOAD_SIZE);     //RePacket to send to subsequent nodes
                call simpleSend.send(sendPackage, AM_BROADCAST_ADDR);                      //Send new package to  all modules
                dbg(FLOODING_CHANNEL, "RePackage has been resent!...\n");               //Debug Message being printed
            } else if(letter -> protocol == PROTOCOL_PINGREPLY){
                dbg(FLOODING_CHANNEL, "RePackage has reached destination...\n");
                call PreviousPackets.insert(letter -> seq, letter -> src);           //Login PAcket information into the Maplist
            }
        } else {
            letter -> TTL -= 1;                                                         //HANDLEFORWARD call
            
            call PreviousPackets.insert(letter -> seq, letter -> src);               //Calling to record package RECEIVED
            call simpleSend.send(*letter, AM_BROADCAST_ADDR);                               //Module that sends packets

            dbg(FLOODING_CHANNEL, "New package has been forwarded with new Time To Live...\n"); //
        }
    }//end of function
}
