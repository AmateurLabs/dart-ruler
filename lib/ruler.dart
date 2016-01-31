library ruler;

import "dart:html";

typedef void UpdateHandler(num dt);

class Ruler {
  List<UpdateHandler> _updateHandlers = new List<UpdateHandler>();
  
  Ruler() {
    
  }
  
  num _oldTime;
  num _time = 0.0;
  
  num get time => _time;
  
  int _animFrameId;
  
  void start() {
    _animFrameId = window.requestAnimationFrame(_update);
  }
  
  void stop() {
    window.cancelAnimationFrame(_animFrameId);
    _oldTime = null;
  }
  
  void _update(num time) {
    _oldTime ??= time;
    if (time - _oldTime > 1000) _oldTime = time;
    num dt = (time - _oldTime) / 1000.0;
    _oldTime = time;
    _time += dt;
    _animFrameId = window.requestAnimationFrame(_update);
    for (UpdateHandler handler in _updateHandlers) handler(dt);
  }
  
  void onUpdate(UpdateHandler handler) => _updateHandlers.add(handler);
}