# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.4.ebuild,v 1.7 2012/04/03 03:12:04 vapier Exp $

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"
IUSE="doc"

RDEPEND="sys-libs/readline
		sys-libs/ncurses
		<dev-libs/libusb-1"
DEPEND="doc? ( app-text/texi2html
			   virtual/latex-base
			   sys-apps/texinfo )
		sys-devel/bison
		sys-devel/flex
		${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h
}

src_compile() {
	econf $(use_enable doc) || die "econf failed"
	VARTEXFONTS="${T}/fonts" emake || die "emake failed"
}

src_install() {
	VARTEXFONTS="${T}/fonts" make DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS README ChangeLog*
}
