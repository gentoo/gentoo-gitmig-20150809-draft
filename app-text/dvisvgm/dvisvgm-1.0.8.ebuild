# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvisvgm/dvisvgm-1.0.8.ebuild,v 1.5 2011/08/12 15:39:51 xarthisius Exp $

EAPI=3

DESCRIPTION="Converts DVI files to SVG"
HOMEPAGE="http://dvisvgm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-macos"
IUSE="test"
# Tests don't work from $WORKDIR: kpathsea tries to search in relative
# directories from where the binary is executed.
# We cannot really use absolute paths in the kpathsea configuration since that
# would make it harder for prefix installs.
RESTRICT="test"

RDEPEND="virtual/tex-base
	app-text/ghostscript-gpl
	media-libs/freetype:2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-util/gtest )"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README || die
}
