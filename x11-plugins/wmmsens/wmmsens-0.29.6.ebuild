# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsens/wmmsens-0.29.6.ebuild,v 1.7 2008/01/06 20:30:15 swegener Exp $

inherit toolchain-funcs

S="${WORKDIR}/${P/_/-}/src"
HOMEPAGE="http://www.digressed.net/wmmsens/"
DESCRIPTION="Window Maker dock app for monitoring your motherboard's hardware sensors"
SRC_URI="http://www.digressed.net/wmmsens/src//${P/_/-}.tar.gz"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	sys-apps/lm_sensors"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove depends at end of Makefile that cause problems
	sed -i -e "/DELETE/q" Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCXX)" OPTFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin wmmsens || die "dobin failed"

	dodoc ../{CREDITS,ChangeLog,README,TODO}
}
