# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs2cl/cvs2cl-2.57.ebuild,v 1.2 2004/07/21 18:49:16 dholm Exp $

#ECVS_SERVER="cvs -d :pserver:anonymous@cvs.red-bean.com:/usr/local/cvs login"
#ECVS_PASS="the key"
#ECVS_MODULE="cvs2cl"
#inherit cvs

DESCRIPTION="produces a GNU-style ChangeLog for CVS-controlled sources"
HOMEPAGE="http://www.red-bean.com/cvs2cl/"
SRC_URI="mirror://gentoo/${P}.pl.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	newbin ${P}.pl ${PN}.pl
}
