# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.3-r2.ebuild,v 1.10 2002/08/14 12:08:08 murphy Exp $

MY_P="vnc-3.3.3r2_unixsrc"
S=${WORKDIR}/vnc_unixsrc
DESCRIPTION="A remote display system which allows you to view a computing 'desktop' environment from anywhere."
SRC_URI="http://www.uk.research.att.com/vnc/dist/${MY_P}.tgz"
HOMEPAGE="http://www.uk.research.att.com/vnc/index.html"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11"

src_compile() {

	#imake and the vnc build process possess amazing suckage skills
	#hoping some poor developer takes pitty on vnc and fixes it

	cd ${S}
	cd Xvnc/config/cf
	#mv Imake.cf Imake.cf.orig
	#insist that the machine is an i386 for the Xvnc build
	#sed -e '/#ifdef linux/a\# define i386' Imake.cf.orig > Imake.cf
	cd ${S}
	xmkmf || die

	#FIXME: my dirty little fix to fix imake brain damage
	make Makefiles || die
	make depend || die
	#cp ${FILESDIR}/vncviewer-makefile-3.3.3r2 ${S}/vncviewer/Makefile

	make all || die

	#FIXME: Xvnc build doesn't respect user CFLAGS settings
	cd Xvnc
	make World || die

}

src_install () {

	cd ${S}
	mkdir -p ${D}/usr/bin
	./vncinstall ${D}/usr/bin || die

}
