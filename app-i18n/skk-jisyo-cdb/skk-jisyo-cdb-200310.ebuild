# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skk-jisyo-cdb/skk-jisyo-cdb-200310.ebuild,v 1.2 2003/11/14 21:24:19 seemant Exp $

IUSE=""

DESCRIPTION="Dictionary files for the SKK Japanese-input software in CDB format"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="app-arch/gzip"
RDEPEND=""

S=${WORKDIR}/${P}

src_install () {

	# install dictionaries
	insinto /usr/share/skk
	doins SKK-JISYO.{L,M,S}.cdb || die
}
