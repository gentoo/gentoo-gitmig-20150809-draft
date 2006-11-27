# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tk707/tk707-0.8-r1.ebuild,v 1.6 2006/11/27 00:33:53 malc Exp $

inherit eutils autotools

DESCRIPTION=" An \"7x7\" type midi drum sequencer for Linux"
HOMEPAGE="http://www-lmc.imag.fr/lmc-edp/Pierre.Saramito/tk707"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gentoo/${P}-updated_tcl2c.patch.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9.0
		>=dev-lang/tcl-8.4
		>=dev-lang/tk-8.4"
DEPEND="${RDEPEND}
		>=sys-devel/automake-1.7
		>=sys-devel/autoconf-2.5"

src_unpack() {
	unpack ${A}
	EPATCH_SOURCE=${S} epatch ${P}-*.patch

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf $(use_enable timdity) $(use_enable lame) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
