# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shtool/shtool-1.5.1-r2.ebuild,v 1.4 2002/07/23 13:28:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
SRC_URI="ftp://ftp.gnu.org/gnu/shtool/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-devel/perl-5.6"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README THANKS VERSION
}
