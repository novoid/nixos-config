{lib,...}:{

  options.my.isnotebook = lib.mkOption {
    description = "True, if the device is a notebook";
    default = true;
    type = lib.types.bool;
  };

  options.my.isvm = lib.mkOption {
    description = "True, if the device is a virtual machine";
    default = false;
    type = lib.types.bool;
  };

  
}

 
