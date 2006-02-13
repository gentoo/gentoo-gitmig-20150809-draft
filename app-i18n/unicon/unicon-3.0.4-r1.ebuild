# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/unicon/unicon-3.0.4-r1.ebuild,v 1.3 2006/02/13 02:48:54 halcy0n Exp $

inherit eutils

# TODO: Figure out how to build the kernel-modules.

VD_P="${P}-20010924"
VD_PATCH="vd_unicon-userland-20031122vd.patch"

DESCRIPTION="CJK (Chinese/Japanese/Korean) console input, display system and input modules."
HOMEPAGE="http://www.gnu.org/directory/UNICON.html
	http://vdr.jp/d/unicon.html"
SRC_URI="http://vdlinux.sourceforge.jp/dists/${VD_P}.tar.gz
	http://vdlinux.sourceforge.jp/dists/${VD_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-x86"
IUSE=""

RDEPEND="virtual/linux-sources
	dev-libs/newt
	dev-libs/pth
	|| ( x11-libs/libX11 virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_unpack() {
	unpack ${VD_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${VD_PATCH}
	epatch ${FILESDIR}/${P}-gcc34.patch
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
