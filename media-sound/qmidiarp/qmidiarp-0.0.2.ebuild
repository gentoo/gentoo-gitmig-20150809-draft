# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmidiarp/qmidiarp-0.0.2.ebuild,v 1.9 2009/08/03 13:18:51 ssuominen Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="MIDI Arpeggiator QMidiArp"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	media-libs/alsa-lib"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-fix_qtdir_in_makefile.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin qmidiarp
	dodoc README
	insinto /usr/share/${PN}
	doins demo.qma demo_up_down.qma
}
