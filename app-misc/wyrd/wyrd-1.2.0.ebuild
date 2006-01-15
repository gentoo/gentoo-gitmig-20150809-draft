# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wyrd/wyrd-1.2.0.ebuild,v 1.2 2006/01/15 18:38:24 twp Exp $

inherit eutils

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/wyrd/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.08
	sys-libs/ncurses
	>=x11-misc/remind-03.00.24"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-no-remind-version-check.patch
}

src_compile() {
	autoreconf || die "autoreconf failed."

	econf || die "configure failed."

	emake || die "make failed."
}

src_install() {
	make DESTDIR="${D}" install || die "install died"

	dodoc ChangeLog
	dohtml doc/manual.html
}
