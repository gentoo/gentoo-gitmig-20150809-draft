# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-0.93.ebuild,v 1.8 2003/02/13 14:13:23 vapier Exp $

MY_P="ymessenger-0.93.0-1.i386.rpm"
S=${WORKDIR}/usr/local
DESCRIPTION="Yahoo's instant messenger client"
SRC_URI=""
HOMEPAGE="http://messenger.yahoo.com/messenger/download/unix.html"

DEPEND=">=app-arch/rpm-3.0.6"
RDEPEND="virtual/x11"

RESTRICT="fetch"

SLOT="0"
LICENSE="yahoo"
KEYWORDS="x86 -ppc -sparc "

src_unpack() {
	if [ ! -f ${DISTDIR}/${MY_P} ] ; then
		die "Please download ${MY_P} from ${HOMEPAGE} and place into ${DISTDIR}"
	fi
	rpm2cpio ${DISTDIR}/${MY_P} | cpio -i --make-directories
}

src_install () {
	exeinto /opt/Yahoo/
	doexe bin/ymessenger
	
	insinto /etc/env.d
	doins ${FILESDIR}/97ymessenger
}
