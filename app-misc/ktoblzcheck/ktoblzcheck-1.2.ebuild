# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ktoblzcheck/ktoblzcheck-1.2.ebuild,v 1.2 2005/01/30 21:41:19 weeve Exp $

DESCRIPTION="Library to check account numbers and bank codes of German banks"
HOMEPAGE="http://ktoblzcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktoblzcheck/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool
	sys-devel/gcc"

src_install() {
	einstall BANKDATA_PATH="${D}/usr/share/ktoblzcheck" || die
}
