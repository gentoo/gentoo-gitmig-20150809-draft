# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skk-jisyo/skk-jisyo-200310.ebuild,v 1.4 2004/01/04 10:30:26 usata Exp $

IUSE=""

DESCRIPTION="Jisyo (dictionary) files for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="app-arch/gzip"
RDEPEND=""

S=${WORKDIR}/${P}

src_install () {

	# install dictionaries
	insinto /usr/share/skk
	doins SKK-JISYO.{L,M,S} || die
}
