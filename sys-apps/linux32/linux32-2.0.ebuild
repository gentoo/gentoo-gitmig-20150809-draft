# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux32/linux32-2.0.ebuild,v 1.2 2005/07/08 04:20:16 vapier Exp $

DESCRIPTION="A simple utility that tricks uname into returning a 32bit environment identifier"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_compile() {
	emake linux32
}

src_install() {
	into /
	dobin linux32 || die
	dosym linux32 /bin/linux64
	doman linux32.8
	dosym linux32.8 /usr/share/man/man1/linux64.8
	dodoc CHANGELOG CREDITS README
}
