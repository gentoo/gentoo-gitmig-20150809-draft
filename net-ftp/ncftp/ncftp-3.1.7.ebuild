# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.7.ebuild,v 1.14 2004/10/23 07:52:27 mr_bones_ Exp $

inherit eutils

IPV6_P="ncftp-317-v6-20040119"
DESCRIPTION="An extremely configurable ftp client"
HOMEPAGE="http://www.ncftp.com/"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2
	ipv6? ( ftp://ftp.cc.chuo-u.ac.jp/pub/IPv6/kame/misc/${IPV6_P}.diff.gz )"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 s390 ppc64 ppc-macos"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ipv6 && epatch ${WORKDIR}/${IPV6_P}.diff
}

src_install() {
	dodir /usr/share
	einstall || die

	dodoc README.txt doc/*.txt
	dohtml doc/html/*.html
}
