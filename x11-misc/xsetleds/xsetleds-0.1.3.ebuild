# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsetleds/xsetleds-0.1.3.ebuild,v 1.1 2003/10/16 01:09:08 seemant Exp $

IUSE=""
DESCRIPTION="xsetleds is a small tool to report and change the keyboard LED states of an X display."
HOMEPAGE="ftp://ftp.unix-ag.org/user/bmeurer/xsetleds"
SRC_URI="${HOMEPAGE}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="virtual/x11"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README TODO
}
