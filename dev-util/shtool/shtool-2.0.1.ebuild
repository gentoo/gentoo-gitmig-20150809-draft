# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shtool/shtool-2.0.1.ebuild,v 1.3 2004/11/15 13:27:13 gustavoz Exp $

DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
SRC_URI="ftp://ftp.gnu.org/gnu/shtool/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ia64 ~ppc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README THANKS VERSION NEWS RATIONAL
}
