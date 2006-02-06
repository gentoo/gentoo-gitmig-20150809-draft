# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/le/le-1.12.5.ebuild,v 1.1 2006/02/06 01:04:04 truedfx Exp $

inherit flag-o-matic

DESCRIPTION="Terminal text editor"
HOMEPAGE="http://www.gnu.org/directory/text/editors/le-editor.html"
SRC_URI="ftp://ftp.yars.free.net/pub/source/le/le-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r5"

src_compile() {
	# Work around linux-headers C++ incompatibility
	# This should be removed once linux-headers is fixed
	append-flags $(test-flags -fpermissive)

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog FEATURES HISTORY INSTALL NEWS README TODO
}
