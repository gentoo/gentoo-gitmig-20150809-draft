# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xdirectfb/xdirectfb-1.0_rc5-r1.ebuild,v 1.1 2004/03/19 16:47:49 spyderous Exp $

inherit eutils

MY_PN="XDirectFB"
MY_PV=${PV/_/-}
MY_P=${MY_PN}-${MY_PV}
MY_V=X430src
S=${WORKDIR}/xc
X=${WORKDIR}/${MY_P}

DESCRIPTION="XDirectFB is a rootless XServer on top of DirectFB"
SRC_URI="mirror://gentoo/${MY_V}-1.tgz
	mirror://gentoo/${MY_V}-2.tgz
	mirror://gentoo/${MY_V}-3.tgz
	mirror://gentoo/truetype.tar.gz
	http://www.directfb.org/download/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86 -sparc ~alpha"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	dev-lang/perl
	>=dev-libs/DirectFB-0.9.17"

src_unpack () {
	unpack ${A}

	cd ${X}
	cp xc-directfb.diff ${S}
	cp -a programs/Xserver/hw/directfb ${S}/programs/Xserver/hw
	cp ${X}/config/cf/* ${S}/config/cf
	cp ${FILESDIR}/host.def ${S}/config/cf/

	cd ${S}
	epatch ./xc-directfb.diff

	cd ${S}/programs/Xserver/hw/directfb
	cp directfbScreen.c rootlessDirectFB.c ${T}


	# update changes in the newer DirectFB versions
	sed "s:DSPF_RGB15:DSPF_ARGB1555:g" \
		${T}/directfbScreen.c > directfbScreen.c

	sed "s:DSPF_RGB15:DSPF_ARGB1555:g" \
		${T}/rootlessDirectFB.c > rootlessDirectFB.c

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
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	chmod 4711 /usr/X11R6/bin/XDirectFB
	chmod 755 /usr/X11R6/bin/startxdfb

	einfo "To start XDirectFB use the startxdfb utility."
}
