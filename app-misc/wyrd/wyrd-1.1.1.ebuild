# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wyrd/wyrd-1.1.1.ebuild,v 1.1 2005/10/26 20:34:11 tove Exp $

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/wyrd/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.08
	sys-libs/ncurses
	>=x11-misc/remind-3.0.23"

src_compile() {
	econf || die "configure failed."

	# parallel make doesn't work
	emake -j1 || die "make failed."
}

src_install() {
	make DESTDIR="${D}" install || die "install died"

	dodoc ChangeLog
	dohtml doc/manual.html
}
