# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lookingglass-bin/lookingglass-bin-0.5.ebuild,v 1.1 2004/07/31 15:39:18 axxo Exp $

inherit eutils

DESCRIPTION="Looking Glass - 3D window manager writen in Java"
HOMEPAGE="https://lg3d.dev.java.net/"
SRC_URI="https://lg3d-core.dev.java.net/files/documents/1834/5501/lg3d-${PV}.tar.gz"
LICENSE="GPL-2"
IUSE="doc"
SLOT="0"
KEYWORDS="~x86"
DEPEND=""
RDEPEND=">=dev-java/sun-jdk-1.5.0_beta2
	>=dev-java/jai-bin-1.1.2-r3
	>=dev-java/sun-java3d-bin-1.32-r1
	|| (
		app-shells/tcsh
		app-shells/csh
	)
	>=dev-java/java-config-1.2.10"

S=${WORKDIR}/lg3d

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/lg3d-dev.patch
	epatch ${FILESDIR}/displayserver.patch
	#epatch ${FILESDIR}/setup.patch
}

src_compile() { :; }

src_install() {
	dodir /opt/lg3d /etc/ /opt/lg3d/etc/
	mv bin ext ext-unbundled lib resources ${D}/opt/lg3d/
	mv etc/lg3d ${D}/etc/
	use doc && dodoc LICENSE.txt
	use doc && dohtml -r docs/

	dodir /etc/X11/Sessions
	dosym /opt/lg3d/bin/lg3d-session /etc/X11/Sessions/lookingglass
	dosym /etc/lg3d /opt/lg3d/etc
	into /opt
	dobin ${FILESDIR}/lg3d-dev ${FILESDIR}/lg3d-session
}


pkg_postinst() {
	echo
	ewarn "To run Looking Glass, the screen must be in 24-bit mode"
	ewarn "To run in window, run lg3d-dev"
	ewarn "To run as a session, run lg3d-session"
	echo
}
