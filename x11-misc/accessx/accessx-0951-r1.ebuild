# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/accessx/accessx-0951-r1.ebuild,v 1.1 2008/01/07 17:19:35 drac Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Interface to the XKEYBOARD extension in X11"
HOMEPAGE="http://cmos-eng.rehab.uiuc.edu/accessx"
SRC_URI="http://cmos-eng.rehab.uiuc.edu/${PN}/software/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	dev-lang/tk"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake CC="$(tc-getCXX)" OPTS="${CXXFLAGS}" \
		XLIBDIR="-L/usr/$(get_libdir)" || die "emake failed."
}

src_install() {
	dobin accessx ax
	dodoc CHANGES README
}
