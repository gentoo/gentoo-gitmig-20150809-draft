# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/check/check-0.8.4.ebuild,v 1.1 2002/11/28 11:07:34 zwelch Exp $

DESCRIPTION="Check is a unit test framework for C." 
HOMEPAGE="http://sourceforge.net/projects/check/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
