# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0.ebuild,v 1.20 2007/02/11 10:44:53 vapier Exp $

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

LICENSE="JNIC"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/glibc"
# non gnu systems need libiconv

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:head -1:head -n 1:g" *
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc Changelog DISTFILES INSTALL INSTALL.ja NEWS README README.ja
}
