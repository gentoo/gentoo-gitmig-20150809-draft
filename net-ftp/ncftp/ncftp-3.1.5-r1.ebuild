# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.5-r1.ebuild,v 1.1 2003/06/17 18:32:04 gmsoft Exp $

IUSE="cjk ipv6"
S=${WORKDIR}/${P}
IPV6_P="ncftp-315-v6-20030207"
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2
	ipv6? ( ftp://ftp.cc.chuo-u.ac.jp/pub/IPv6/kame/misc/${IPV6_P}.diff.gz )"
HOMEPAGE="http://www.ncftp.com/"

SLOT="0"
LICENSE="Clarified-Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

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
