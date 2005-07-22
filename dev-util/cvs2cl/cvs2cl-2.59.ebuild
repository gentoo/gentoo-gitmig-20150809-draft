# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs2cl/cvs2cl-2.59.ebuild,v 1.3 2005/07/22 06:40:15 ka0ttic Exp $

DESCRIPTION="produces a GNU-style ChangeLog for CVS-controlled sources"
HOMEPAGE="http://www.red-bean.com/cvs2cl/"
SRC_URI="mirror://gentoo/${P}.pl.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	newbin ${P}.pl ${PN} || die
}
