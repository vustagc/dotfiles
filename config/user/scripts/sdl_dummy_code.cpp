#include <SDL3/SDL.h>
#include <stdbool.h>
#include <stdio.h>
// only needed in main
#include <SDL3/SDL_main.h>

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

SDL_Window* window = NULL;

int main(int argc, char* argv[]) {
  // Initialize SDL
  if (!SDL_Init(SDL_INIT_VIDEO)) {
    printf("SDL could not be initialized! %s", SDL_GetError());
    return 0;
  }

  bool quit = false;

  while (!quit) {
    // main loop
  }

  return 0;
}
