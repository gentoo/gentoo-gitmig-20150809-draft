# Config file for /etc/init.d/foldingathome

# Enter options here to be passed to the Folding client:
#
#  -oneunit	Instruct the client to quit following the completion of one work unit.
#  -verbosity x Sets the output level, from 1 to 9 (max). The default is 3
#  -pause       Pause after finishing & trying to send current unit
#  -forceasm    Force core assembly optimizations to be used if available
#  -forceSSE	On machines with an AMD processor, Core_78 gives priority to 3DNow over
#		SSE -- this overrides that.
#  -advmethods  Request to be assigned any new Cores or work units.
#
# A full listing of options can be found here:
# http://www.stanford.edu/group/pandegroup/folding/console-userguide.html
# But use of other options are not recommended when using the Folding client
# as a service.
#
FOLD_OPTS="-advmethods"

# Number of clients to run
#
# Folding@Home isn't multithreaded, so if you're running multiple CPU's
# you will need to run a client to run for each of your CPU's in order
# to achieve the best performance for Folding@Home. Up to a maximum of 8.
# Ex. A dual CPU system would use CPU=2
#
CPU=1
