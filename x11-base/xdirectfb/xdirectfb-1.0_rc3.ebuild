# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xdirectfb/xdirectfb-1.0_rc3.ebuild,v 1.2 2002/11/18 06:49:54 blizzy Exp $

MY_PN="XDirectFB"
MY_PV=${PV/_/-}
MY_P=${MY_PN}-${MY_PV}
MY_V=X4.2.99.3
S=${WORKDIR}/xc
X=${WORKDIR}/${MY_P}

DESCRIPTION="XDirectFB is a rootless XServer on top of DirectFB"
SRC_URI="http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-1.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-2.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-3.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-4.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz
	http://www.directfb.org/download/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

SLOT="0"
LICENSE="X11"
KEYWORDS="~x86 ~sparc ~sparc64"

PROVIDE="virtual/x11"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	sys-devel/perl
	dev-libs/DirectFB"
	
src_unpack () {
	unpack ${A}

	cd ${X}
	cp xc-directfb.diff ${S} 
	cp -a programs/Xserver/hw/directfb ${S}/programs/Xserver/hw
	cp ${X}/config/cf/* ${S}/config/cf
	cp ${FILESDIR}/host.def ${S}/config/cf/
	
	cd ${S}
	patch -p0 < xc-directfb.diff || die
}

src_compile() {
	emake World || die
}

src_install() {
#	make install DESTDIR=${D}

	exeinto /usr/X11R6/bin
	doexe ${S}/programs/Xserver/XDirectFB 
	doexe ${FILESDIR}/startxdfb 

	mv ${S}/programs/Xserver/hw/directfb/XDirectFB._man ./XDirectFB.1x
	insinto /usr/X11R6/man/man1
	doins ${S}/XDirectFB.1x
	dodir /etc/skel
	dodir /etc/X11/xinit
	cp ${FILESDIR}/.dfbserverrc ${D}/etc/skel
	cp ${FILESDIR}/dfbserverrc ${D}/etc/X11/xinit
	
	dohtml ${S}/programs/Xserver/hw/directfb/XDirectFB.1x.html
	
	cd ${X}
	dodoc AUTHORS ChangeLog INSTALL README TODO
}

pkg_postinst() {
	chmod 4711 /usr/X11R6/bin/XDirectFB
	chmod 755 /usr/X11R6/bin/startxdfb

	einfo "To start XDirectFB use the startxdfb utility."
}
