#include <Timer.h>
#include "../../includes/CommandMsg.h"
#include "../../includes/packet.h"

configuration NeighborDiscoveryC {
	provides interface NeighborDiscovery;
}
implementation {

	components NeighborDiscoveryP;
	NeighborDiscovery = NeighborDiscoveryP;

	components RandomC as Random;
    NeighborDiscoveryP.Random -> Random;
    
    components new TimerMilliC() as Timer;
    NeighborDiscoveryP.Timer -> Timer;

    components new SimpleSendC(AM_PACK);
    NeighborDiscoveryP.Sender -> SimpleSendC;

    components new HashmapC(uint32_t, 20);
    NeighborDiscoveryP.NeighborTable -> HashmapC;

    //components DistanceVectorRoutingC;
    //NeighborDiscoveryP.DistanceVectorRouting -> DistanceVectorRoutingC;

    components LinkStateRoutingC;                               //Added for Project 4 impletation
    NeighborDiscoveryP.LinkStateRouting -> LinkStateRoutingC;
}