# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvs2cl/cvs2cl-2.59.ebuild,v 1.1 2010/06/19 00:28:31 abcd Exp $

DESCRIPTION="produces a GNU-style ChangeLog for CVS-controlled sources"
HOMEPAGE="http://www.red-bean.com/cvs2cl/"
SRC_URI="mirror://gentoo/${P}.pl.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	newbin ${P}.pl ${PN} || die
}
