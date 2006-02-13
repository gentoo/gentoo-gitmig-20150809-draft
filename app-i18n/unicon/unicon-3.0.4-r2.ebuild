# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/unicon/unicon-3.0.4-r2.ebuild,v 1.2 2006/02/13 02:48:54 halcy0n Exp $

inherit eutils

# TODO: Figure out how to build the kernel-modules.

DEB_PV="9.2"

DESCRIPTION="CJK (Chinese/Japanese/Korean) console input, display system and input modules."
HOMEPAGE="http://www.gnu.org/directory/UNICON.html"
SRC_URI="mirror://debian/pool/main/u/unicon/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/u/unicon/${PN}_${PV}-${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/linux-sources
	dev-libs/newt
	dev-libs/pth
	|| ( x11-libs/libX11 virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${PN}_${PV}-${DEB_PV}.diff.gz
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "make failed"
	emake data || die "make data failed"
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"
	make prefix=${D}/usr data-install || die "make data-install failed"

	dosed /usr/lib/unicon/load-unimap.sh

	newconfd ${FILESDIR}/unicon.confd unicon
	newinitd ${FILESDIR}/unicon.initd unicon
}

pkg_postinst() {
	ewarn
	ewarn "You need to patch your kernel in order to use this software."
	ewarn "The latest unicon patch can be found at"
	ewarn "	${HOMEPAGE}"
	ewarn "Please make sure you remove consolefont from boot runlevel"
	ewarn "and add unicon after editting /etc/conf.d/unicon, and the reboot."
	ewarn
	ewarn "# rc-update del consolefont boot"
	ewarn "# rc-update add unicon boot"
	ewarn
}
