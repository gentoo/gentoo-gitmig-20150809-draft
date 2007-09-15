# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wyrd/wyrd-1.4.3b.ebuild,v 1.1 2007/09/15 07:30:24 tove Exp $

inherit eutils

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/wyrd/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="unicode"

DEPEND=">=dev-lang/ocaml-3.08
	sys-libs/ncurses
	>=x11-misc/remind-03.01"

pkg_setup() {
	use unicode || return 0
	if ! built_with_use sys-libs/ncurses unicode ; then
		eerror "To use unicode in wyrd you must build sys-libs/ncurses"
		eerror "with unicode support."
		die "Please rebuilt sys-libs/ncurses with unicode in USE!"
	fi
}

src_compile() {
	econf $(use_enable unicode utf8 ) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install died"

	dodoc ChangeLog || die "dodoc failed"
	dohtml doc/manual.html || die "dohtml failed"
}
