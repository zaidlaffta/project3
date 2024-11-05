#include <Timer.h>
#include "../../includes/CommandMsg.h"
#include "../../includes/packet.h"

configuration DistanceVectorRoutingC {
    provides interface DistanceVectorRouting;
}

implementation {
    components DistanceVectorRoutingP;
    DistanceVectorRouting = DistanceVectorRoutingP;

    components new SimpleSendC(AM_PACK);
    DistanceVectorRoutingP.Sender -> SimpleSendC;

    components NeighborDiscoveryC;
    DistanceVectorRoutingP.NeighborDiscovery -> NeighborDiscoveryC;

    components new TimerMilliC() as DVRTimer;
    DistanceVectorRoutingP.DVRTimer -> DVRTimer;

    components RandomC as Random;
    DistanceVectorRoutingP.Random -> Random;

    components TransportC as Transport;
    DistanceVectorRoutingP.Transport -> Transport;
}