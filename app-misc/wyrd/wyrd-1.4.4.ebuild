# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wyrd/wyrd-1.4.4.ebuild,v 1.2 2008/10/26 19:09:28 maekke Exp $

inherit eutils

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://pessimization.com/software/wyrd/"
SRC_URI="http://pessimization.com/software/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="unicode"

DEPEND=">=dev-lang/ocaml-3.08
	sys-libs/ncurses
	>=x11-misc/remind-03.01"
RDEPEND=${DEPEND}

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
