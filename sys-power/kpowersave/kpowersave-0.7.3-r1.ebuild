# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/kpowersave/kpowersave-0.7.3-r1.ebuild,v 1.3 2009/11/11 02:07:23 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde eutils

PATCH_LEVEL=3

DESCRIPTION="KDE front-end to powersave daemon"
HOMEPAGE="http://powersave.sf.net/"
SRC_URI="mirror://sourceforge/powersave/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2
	mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.4
	dev-libs/dbus-qt3-old
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libXtst
	=kde-base/kdelibs-3*"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto"

need-kde 3.5

src_unpack() {
	unpack ${A}
	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
	epatch "${WORKDIR}/${P/-/_}-${PATCH_LEVEL}.diff"
	epatch "${S}/debian/patches/05-battery_rescan.patch"
}

pkg_postinst() {
	einfo "Making sure that config directory is readable"
	einfo "chmod 755 ${ROOT}/usr/share/config"
	chmod 755 "${ROOT}/usr/share/config"
}
