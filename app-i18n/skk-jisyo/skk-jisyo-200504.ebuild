# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skk-jisyo/skk-jisyo-200504.ebuild,v 1.2 2007/07/08 20:37:50 grobian Exp $

DESCRIPTION="Jisyo (dictionary) files for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""

DEPEND="app-arch/gzip"
RDEPEND=""

src_install() {
	# install dictionaries
	insinto /usr/share/skk
	doins SKK-JISYO.{L,M,S} || die
}
