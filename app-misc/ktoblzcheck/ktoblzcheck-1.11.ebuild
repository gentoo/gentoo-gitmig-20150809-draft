# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ktoblzcheck/ktoblzcheck-1.11.ebuild,v 1.5 2006/10/19 15:50:05 kloeri Exp $

DESCRIPTION="Library to check account numbers and bank codes of German banks"
HOMEPAGE="http://ktoblzcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktoblzcheck/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall BANKDATA_PATH="${D}/usr/share/ktoblzcheck" || die
}
