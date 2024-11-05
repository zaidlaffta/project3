interface MapList<t, s> {
   command void insertVal(t key, s val);
   command void removeVal(t key, s val);
   command bool containsList(t key);
   command bool containsVal(t key, s val);
   command bool isEmpty();
   command bool listIsEmpty(t key);
   command void printList(t key);
}