#!/bin/bash
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
