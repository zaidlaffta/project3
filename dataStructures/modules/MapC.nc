
generic module MapC(typedef t, typedef s, uint16_t hashSize, uint16_t mapSize){
	provides interface Map<t, s>;
}
implementation {
	typedef struct List {
        s container[k];
        uint16_t size;
    } List;

    typedef struct MapListEntry {
        struct List list;
        t key;
    } MapListEntry;

    MapListEntry map[n];
    MapListEntry* lru[n];
    uint16_t numofVals = 0;
}