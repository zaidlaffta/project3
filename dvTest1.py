from TestSim import TestSim

def main():
    s = TestSim()

    # Simulate network not running
    s.runTime(1)

    s.loadTopo("long_line.topo")
    s.loadNoise("no_noise.txt")
    s.bootAll()

    s.addChannel(s.COMMAND_CHANNEL)
    #s.addChannel(s.GENERAL_CHANNEL)
    s.addChannel(s.ROUTING_CHANNEL)

    s.routeDMP(1)
    s.runTime(10)

    s.routeDMP(2)
    s.runTime(10)

    s.routeDMP(3)
    s.runTime(10)

    s.routeDMP(9)
    s.runTime(10)

    s.ping(1, 8, "First ping")
    s.runTime(10)

    s.ping(2, 7, "Before node 3 off")
    s.runTime(20)

    s.moteOff(3)
    s.runTime(40)

    s.ping(2, 4, "After node 3 off")
    s.runTime(20)

    s.routeDMP(2)
    s.runTime(20)

    s.routeDMP(4)
    s.runTime(20)

    s.routeDMP(5)
    s.runTime(20)

if __name__ == '__main__':
    main()