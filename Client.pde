class Client {
  Integer id ;
  ArrayList <File> storage;
  PVector  Pos;
  Client(Integer ID, PVector ipos) {
    id =ID;
    Pos = ipos;
    storage =new  ArrayList <File> ();
  }

  void addFile (File f) {
    boolean found = false;
    for (int i = 0; i < storage.size(); i++) {
      if (storage.get(i)==f) {
        found = true ;
      }
    }
    if (!found) {
      this.storage.add(f);
    }
  }

  Integer searchfileName ( String Name, IndexServer S) {
    for (int i = 0; i < storage.size(); i++) {
      if (storage.get(i).Name.equals( Name)) {
     
        return -1;
      }
    }
    Integer j =S.SeekIndex(Name);
    return j ;
  }
  void updateServer (IndexServer S) {

    for (int i = 0; i < storage.size(); i++) {
      S.addFileToMap ( this.storage.get(i), this.id);
    }
  }
  void downloadfile(Client C, String FileName) {
    File f= null ;
    for (int i = 0; i < C.storage.size(); i++) {
      if (C.storage.get(i).Name.equals( FileName)) {
        println("file download");
        f=C.storage.get(i);
        break;
    } 
    }
    if (f!=null){
    
    println(" vro ? ");
  }
    
    this.storage.add(f);
  }
}
