# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/directvnc/directvnc-0.6.1.ebuild,v 1.3 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Very thin VNC client for unix framebuffer systems"
HOMEPAGE="http://adam-lilienthal.de/directvnc"
DEPEND="dev-libs/DirectFB sys-devel/automake sys-devel/autoconf"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	
	#fix src/dfb.c to handle the new API changes in DirectFB
	cp ${FILESDIR}/dfb.c .
	
	#fix broken Makefile.am
	mv Makefile.am Makefile.am.orig
	sed -e 's/-$(DIRECTFB_LIBS)/$(DIRECTFB_LIBS)/' Makefile.am.orig > Makefile.am
	cd ..
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make \
		DESTDIR=${D} \
		docsdir=/usr/share/doc/${PF} \
		install || die
}
