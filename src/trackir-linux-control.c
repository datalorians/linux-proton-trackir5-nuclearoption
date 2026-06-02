#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "linuxtrack.h"

linuxtrack_state_type ltr_init(const char *cust_section);
linuxtrack_state_type ltr_suspend(void);
linuxtrack_state_type ltr_wakeup(void);
linuxtrack_state_type ltr_recenter(void);
linuxtrack_state_type ltr_get_tracking_state(void);

static const char *state_name(linuxtrack_state_type state)
{
  switch(state){
    case LINUXTRACK_OK: return "ok";
    case INITIALIZING: return "initializing";
    case RUNNING: return "running";
    case PAUSED: return "paused";
    case STOPPED: return "stopped";
    case err_NOT_INITIALIZED: return "not-initialized";
    case err_SYMBOL_LOOKUP: return "symbol-lookup-error";
    case err_NO_CONFIG: return "no-config";
    case err_NOT_FOUND: return "not-found";
    case err_PROCESSING_FRAME: return "processing-frame-error";
    default: return "unknown";
  }
}

static int run_action(const char *action)
{
  if(access("/tmp/ltr_m_sock", F_OK) != 0){
    fprintf(stderr, "linuxtrack server is not running\n");
    return 1;
  }

  linuxtrack_state_type state = ltr_init(NULL);

  if(state < LINUXTRACK_OK){
    fprintf(stderr, "ltr_init failed: %s\n", state_name(state));
    return 1;
  }

  if(strcmp(action, "recenter") == 0 || strcmp(action, "center") == 0){
    state = ltr_recenter();
  }else if(strcmp(action, "pause") == 0 || strcmp(action, "suspend") == 0){
    state = ltr_suspend();
  }else if(strcmp(action, "resume") == 0 || strcmp(action, "wakeup") == 0){
    state = ltr_wakeup();
  }else if(strcmp(action, "toggle") == 0){
    state = ltr_get_tracking_state();
    if(state == PAUSED){
      state = ltr_wakeup();
    }else{
      state = ltr_suspend();
    }
  }else if(strcmp(action, "state") == 0){
    state = ltr_get_tracking_state();
    printf("%s\n", state_name(state));
    return state < LINUXTRACK_OK ? 1 : 0;
  }else{
    fprintf(stderr, "usage: trackir-linux-control {center|pause|resume|toggle|state}\n");
    return 2;
  }

  if(state < LINUXTRACK_OK){
    fprintf(stderr, "%s failed: %s\n", action, state_name(state));
    return 1;
  }

  return 0;
}

int main(int argc, char **argv)
{
  if(argc != 2){
    fprintf(stderr, "usage: trackir-linux-control {center|pause|resume|toggle|state}\n");
    return 2;
  }

  return run_action(argv[1]);
}
