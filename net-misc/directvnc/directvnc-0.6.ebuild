# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/directvnc/directvnc-0.6.ebuild,v 1.1 2002/05/31 15:00:49 g2boojum Exp $

DESCRIPTION="Very thin VNC client for unix framebuffer systems"

HOMEPAGE="http://adam-lilienthal.de/directvnc"

LICENSE="GPL-2"

DEPEND=">=dev-libs/DirectFB-0.9.10 sys-devel/automake sys-devel/autoconf"

#RDEPEND=""

SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	#fix broken Makefile.am
	cd src
	mv Makefile.am Makefile.am.orig
	sed -e 's/-$(DIRECTFB_LIBS)/$(DIRECTFB_LIBS)/' Makefile.am.orig > Makefile.am
	cd ..
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
}
