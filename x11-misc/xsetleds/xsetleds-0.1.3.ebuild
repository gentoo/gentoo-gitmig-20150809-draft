# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsetleds/xsetleds-0.1.3.ebuild,v 1.12 2005/04/01 19:15:17 agriffis Exp $

DESCRIPTION="small tool to report and change the keyboard LED states of an X display"
HOMEPAGE="ftp://ftp.unix-ag.org/user/bmeurer/xsetleds/"
SRC_URI="ftp://ftp.unix-ag.org/user/bmeurer/xsetleds/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ~mips amd64 ia64"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README TODO
}
