# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

A=reminder-0.3.1.tar.gz
S=${WORKDIR}/reminder-0.3.1
DESCRIPTION="a Reminder Plugin for Gkrellm"
SRC_URI="http://www.engr.orst.edu/~simonsen/reminder/${A}"
HOMEPAGE="http://www.engr.orst.edu/~simonsen/reminder"

DEPEND=">=app-admin/gkrellm-1.2.1"

src_compile() {
	make || die
}

src_install () {

    exeinto /usr/lib/gkrellm/plugins
    doexe reminder.so
    dodoc README ChangeLog COPYING 
}

