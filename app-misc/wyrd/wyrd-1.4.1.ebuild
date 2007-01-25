# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/wyrd/wyrd-1.4.1.ebuild,v 1.2 2007/01/25 04:24:40 beandog Exp $

DESCRIPTION="Text-based front-end to Remind"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/wyrd/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/wyrd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.08
	sys-libs/ncurses
	>=x11-misc/remind-03.00.24"

src_install() {
	make DESTDIR="${D}" install || die "install died"

	dodoc ChangeLog || die "dodoc failed"
	dohtml doc/manual.html || die "dohtml failed"
}
