# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-reminder/gkrellm-reminder-0.3.0.ebuild,v 1.1 2001/09/19 03:02:32 lamer Exp $
A=reminder-0.3.0.tar.gz
S=${WORKDIR}/reminder-0.3.0
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://www.engr.orst.edu/~simonsen/reminder/${A}"
HOMEPAGE="http://"
DEPEND=""

#RDEPEND=""

src_compile() {
	make || die
}

src_install () {

	 insinto /usr/lib/gkrellm/plugins/
	 doins reminder.so
	 dodoc README INSTALL ChangeLog COPYING
}

