# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3diags/mp3diags-1.0.00.045.ebuild,v 1.2 2009/12/20 19:38:19 ayoy Exp $

EAPI="2"

inherit qt4-r2

MY_PN=${PN/mp3d/MP3D}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Qt-based MP3 diagnosis and repair tool"
HOMEPAGE="http://mp3diags.sourceforge.net"
SRC_URI="doc? ( http://web.clicknet.ro/mciobanu/${PN}/${MY_PN}_Src+Doc-${PV}.tar.gz )
	!doc? ( http://web.clicknet.ro/mciobanu/${PN}/${MY_PN}-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="x11-libs/qt-gui:4[debug?]
	>=dev-libs/boost-1.37"
RDEPEND="${DEPEND}
	x11-libs/qt-svg:4[debug?]"

src_install() {
	dobin bin/${MY_PN} || die "installing binary failed"
	dodoc changelog.txt || die "dodoc failed"

	domenu desktop/${MY_PN}.desktop || die "installing dekstop file failed"

	local icon_sizes="16 22 24 32 36 48"
	for size in ${icon_sizes}; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins desktop/${MY_PN}${size}.png ${MY_PN}.png \
			|| die "installing icons failed"
	done

	if use doc; then
		dohtml doc/* || die "installing documentation failed"
	fi
}
