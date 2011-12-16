#!/bin/bash

source tests-common.sh

inherit eutils

tbegin "initial stack state"
estack_pop teststack
# Should be empty and thus return 1
[[ $? -eq 1 ]]
tend $?

tbegin "simple push/pop"
estack_push ttt 1
estack_pop ttt
tend $?

tbegin "simple push/pop var"
estack_push xxx "boo ga boo"
estack_pop xxx i
[[ $? -eq 0 ]] && [[ ${i} == "boo ga boo" ]]
tend $?

tbegin "multi push/pop"
estack_push yyy {1..10}
i=0
while estack_pop yyy ; do
	: $(( i++ ))
done
[[ ${i} -eq 10 ]]
tend $?

tbegin "umask push/pop"
u0=$(umask)
eumask_push 0000
u1=$(umask)
eumask_pop
u2=$(umask)
[[ ${u0}:${u1}:${u2} == "${u0}:0000:${u0}" ]]
tend $?

texit
