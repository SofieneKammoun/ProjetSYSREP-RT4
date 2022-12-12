class IndexServer {
  HashMap<File, Integer> indexMap ; // file is key Integer is
  PVector  Pos;
  IndexServer(PVector pos) {
    indexMap = new HashMap<File, Integer>();
    Pos = pos;
  }
  Integer clientID;
  Integer CFound;
  Integer SeekIndex( String seekName) {
    boolean found=false;
    for (HashMap.Entry<File, Integer> entry : this.indexMap.entrySet()) {
      File f = entry.getKey();
      clientID = entry.getValue();
      println(f.Name +"=" +seekName+"|| id = "+ clientID);
      if(f.Name.equals( seekName)) {
        found = true;
       
        CFound=clientID;
      }
    }
    if (!found) {
      return -2;
    } else {
      return CFound;
    }
  }
  void addFileToMap (File f, Integer id) {
    this.indexMap.put(f, id);
  }
}
