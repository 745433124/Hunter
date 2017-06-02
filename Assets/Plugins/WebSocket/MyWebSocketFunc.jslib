var MyPlugin = {
    OpenExpUrl: function(url){
	var str = Pointer_stringify(url);
        window.open(str);
    },
     LoadConfig: function(objectName,callback){
	var p1 = Pointer_stringify(objectName);
	var p2 = Pointer_stringify(callback);
	GetConfig(p1,p2);
    },
     LoadUserInfo: function(objectName,callback){
	var p1 = Pointer_stringify(objectName);
	var p2 = Pointer_stringify(callback);
	Getuinfo(p1,p2);
    },
     LoadPlaybackParam: function(){
	ask_url();
    },
    ClosePage:function(){
        closepage();
    },
    WebGlFullScreen:function(){
	SetFullscreen(1);
    }
};
mergeInto(LibraryManager.library, MyPlugin);