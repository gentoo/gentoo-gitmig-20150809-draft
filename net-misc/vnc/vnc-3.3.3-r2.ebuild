# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.3-r2.ebuild,v 1.17 2003/06/09 11:51:44 weeve Exp $

IUSE="java"

MY_P="vnc-3.3.3r2_unixsrc"
S=${WORKDIR}/vnc_unixsrc
DESCRIPTION="A remote display system which allows you to view a computing 'desktop' environment from anywhere."
SRC_URI="http://www.uk.research.att.com/vnc/dist/${MY_P}.tgz"
HOMEPAGE="http://www.uk.research.att.com/vnc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -sparc "

DEPEND="virtual/x11
	java? virtual/jre"

src_compile() {

	#imake and the vnc build process possess amazing suckage skills
	#hoping some poor developer takes pitty on vnc and fixes it

	#cd Xvnc/config/cf
	#mv Imake.cf Imake.cf.orig
	#insist that the machine is an i386 for the Xvnc build
	#sed -e '/#ifdef linux/a\# define i386' Imake.cf.orig > Imake.cf

	xmkmf || die

	#FIXME: my dirty little fix to fix imake brain damage
	make Makefiles || die
	make depend || die
	#cp ${FILESDIR}/vncviewer-makefile-3.3.3r2 ${S}/vncviewer/Makefile
	
	touch ${S}/vncviewer/vncviewer.man
	make World || die

	#FIXME: Xvnc build doesn't respect user CFLAGS settings
	cd Xvnc
	make World || die

}

src_install () {

	dodir /usr/bin
	./vncinstall ${D}/usr/bin || die

}
