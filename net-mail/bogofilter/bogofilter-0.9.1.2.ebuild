# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bogofilter/bogofilter-0.9.1.2.ebuild,v 1.2 2003/02/13 14:23:49 vapier Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
		>=sys-libs/db-3*"

S="${WORKDIR}/${P}"

src_compile() {
	econf
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe bogofilter

	doman bogofilter.1
	dodoc NEWS README TODO

	einfo "Read bogofilter's manual 'man bogofilter' for tips on how"
	einfo "to integrate bogofilter with procmail and/or mutt."
	einfo ""
	einfo "The former being highly desirable to install in order to"
	einfo "fully use bogofilter."
}
