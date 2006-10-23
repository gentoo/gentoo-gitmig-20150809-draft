# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.1.ebuild,v 1.7 2006/10/23 14:35:33 gustavoz Exp $

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="http://savannah.nongnu.org/download/avrdude/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"

IUSE="doc"
RDEPEND="sys-libs/readline
		sys-libs/ncurses
		dev-libs/libusb"
DEPEND="doc? ( app-text/texi2html
			   virtual/tetex
			   sys-apps/texinfo )
		sys-devel/bison
		sys-devel/flex
		${RDEPEND}"
src_unpack() {
	unpack "${A}"
	cd "${S}"

	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h
}

src_compile() {
	econf $(use_enable doc) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS README ChangeLog*
}
