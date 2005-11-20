# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.0.ebuild,v 1.2 2005/11/20 16:37:35 brix Exp $

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="http://savannah.nongnu.org/download/avrdude/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"

IUSE="doc"
RDEPEND="sys-libs/readline
		sys-libs/ncurses
		dev-libs/libusb"
DEPEND="doc? ( app-text/texi2html
			   app-text/tetex
			   sys-apps/texinfo )
		sys-devel/bison
		sys-devel/flex
		${RDEPEND}"

src_compile() {
	econf $(use_enable doc) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS README \
		ChangeLog ChangeLog-2001 ChangeLog-2002 ChangeLog-2003
}
