# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/migemo-dict/migemo-dict-200309.ebuild,v 1.1 2003/09/30 17:47:43 usata Exp $

IUSE=""

DESCRIPTION="Dictionary files for the Migemo and C/Migemo"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/${P}"

DEPEND=""

src_install() {

	insinto /usr/share/migemo
	doins migemo-dict

}
