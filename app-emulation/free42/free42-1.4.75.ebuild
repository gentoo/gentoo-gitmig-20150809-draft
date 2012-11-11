# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/free42/free42-1.4.75.ebuild,v 1.1 2012/11/11 19:32:05 nimiux Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="An HP-42S Calculator Simulator"
HOMEPAGE="http://thomasokken.com/free42/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa"

DEPEND="dev-libs/atk
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
	media-libs/alsa-lib"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -e '/^CXXFLAGS :=/{s/-g //;s/$/ \$\{CXXFLAGS\}/}' \
		"${S}/gtk/Makefile" || die
	sed -i -e '/^LDFLAGS =/{s/=/:=/;s/$/ \$\{LDFLAGS\}/}' \
		"${S}/gtk/Makefile" || die
	sed -i -e '/^LDFLAGS +=/d' "${S}/gtk/Makefile" || die
	epatch "${FILESDIR}"/${P}-fix-alsa.patch
}

src_compile() {
	local myconf
	use alsa && myconf="AUDIO_ALSA=yes"
	emake -j1 CXX="$(tc-getCXX)" ${myconf} -C "${S}/gtk"
}

src_install() {
	dodoc CREDITS HISTORY README TODO
	dobin gtk/free42bin
}
