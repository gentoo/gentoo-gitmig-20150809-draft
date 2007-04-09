# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/clrngd/clrngd-1.0.3.ebuild,v 1.6 2007/04/09 14:23:01 welp Exp $

DESCRIPTION="Clock randomness gathering daemon"
HOMEPAGE="http://echelon.pl/pubs/"
SRC_URI="http://echelon.pl/pubs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libc sys-devel/gcc"
RDEPEND="virtual/libc"

src_compile() {
	econf --bindir=/usr/sbin || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	exeinto /etc/init.d
	newexe ${FILESDIR}/clrngd-init.d clrngd
	insinto /etc/conf.d
	newins ${FILESDIR}/clrngd-conf.d clrngd
}
