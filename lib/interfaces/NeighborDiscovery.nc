#include "../../includes/packet.h"
interface NeighborDiscovery {
	
	command error_t start();
   	command void discover(pack* packet);
   	command void printNeighbors();
   	command uint32_t* getNeighbors();
   	command uint16_t getNeighborListSize();

}