#!/bin/bash

ollama serve &
ollama run gemma3:1b && killall ollama
