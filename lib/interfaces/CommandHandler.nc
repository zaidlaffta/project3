interface CommandHandler{
   // Events
   event void ping(uint16_t destination, uint8_t *payload);
   event void printNeighbors();
   event void printRouteTable();
   event void printLinkState();           //Project 4 Handler
   //event void printDistanceVector();
   //event void printMessage(uint_t *payload); //integrated as part of project 4
   event void setTestServer(uint8_t port);
   event void setTestClient(uint8_t dest, uint8_t srcPort, uint8_t destPort, uint16_t transfer);
   event void setClientClose(uint8_t dest, uint8_t srcPort, uint8_t destPort);
   event void setAppServer();
   event void setAppClient();
}
