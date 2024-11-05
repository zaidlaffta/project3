#include "../../includes/packet.h"

interface LinkStateRouting {
    command error_t start();
    command void ping(uint16_t destination, uint8_t *payload);
    command void routePacket(pack* myMsg);
    command void handleLS(pack* myMsg);
    command void handleNeighborLost(uint16_t lostNeighbor);
    command void handleNeighborFound();
    command void printRouteTable();
    
    //are in the book
    //command setAppServer();                 //takes in parametersfrm transport needs to print out that is connected. hardcoed nodes that are suposed to get connected- Geras
    //command setAppClient(port,username);    //for whomever is trying to make the connection is upposed to present their ID and th the user name that sent through
    //command broadcast(clientport, myMSG);   // The messaeg shgould be the pack made in makepacks. Connection should already be established. Send the packet to server; 
    //command unicast();                      //should check if connection is made succesfully, if it is it sends it to window
    
}