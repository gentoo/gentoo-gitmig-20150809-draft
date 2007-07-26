# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.1.9.ebuild,v 1.14 2007/07/26 05:49:02 vapier Exp $

inherit eutils

IPV6_P="ncftp-319-v6-20050419"
DESCRIPTION="An extremely configurable ftp client"
HOMEPAGE="http://www.ncftp.com/"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.bz2
	http://www.thrysoee.dk/ncftp/ncftp-${PV}_editcmd.patch
	ipv6? ( ftp://ftp.kame.net/pub/kame/misc/${IPV6_P}.diff.gz )"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${P}-src.tar.bz2
	cd "${S}"
	use ipv6 && epatch "${DISTDIR}"/${IPV6_P}.diff.gz
	epatch "${DISTDIR}"/ncftp-${PV}_editcmd.patch
	epatch "${FILESDIR}"/ncftp-${PV}-build.patch
}

src_install() {
	dodir /usr/share
	einstall || die

	dodoc README.txt doc/*.txt
	dohtml doc/html/*.html
}
