# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.5-r1.ebuild,v 1.7 2004/07/15 00:01:05 agriffis Exp $

inherit eutils

IPV6_P="ncftp-315-v6-20030207"
DESCRIPTION="An extremely configurable ftp client"
HOMEPAGE="http://www.ncftp.com/"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2
	ipv6? ( ftp://ftp.cc.chuo-u.ac.jp/pub/IPv6/kame/misc/${IPV6_P}.diff.gz )"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"
IUSE="cjk ipv6"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${P}-src.tar.bz2
	cd ${S}

	use cjk && epatch ${FILESDIR}/${P}-cjk.patch
	use ipv6 && epatch ${DISTDIR}/${IPV6_P}.diff.gz
}

src_install() {
	dodir /usr/share
	einstall || die

	dodoc README.txt doc/*.txt
	dohtml doc/html/*.html
}
