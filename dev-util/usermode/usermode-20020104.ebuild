# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/usermode/usermode-20020104.ebuild,v 1.4 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/tools
DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="mirror://sourceforge/user-mode-linux/uml_utilities_20020104.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

DEPEND=""
#RDEPEND=""

src_compile() {

	make CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE -g -Wall" all
}

src_install () {

	make DESTDIR=${D} install

	dodoc COPYING 	
}
