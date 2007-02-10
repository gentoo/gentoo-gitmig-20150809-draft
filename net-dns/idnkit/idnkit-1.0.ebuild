# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0.ebuild,v 1.19 2007/02/10 20:00:29 yoswink Exp $

S="${WORKDIR}/${P}-src"

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

SLOT="0"
LICENSE="JNIC"
KEYWORDS="alpha ~amd64 hppa ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="sys-libs/glibc"
# non gnu systems need libiconv

src_unpack()
{
	unpack ${A} ; cd ${S}
	sed -i -e "s:head -1:head -n 1:g" *
}

src_install()
{
	make DESTDIR="${D}" install
	dodoc Changelog DISTFILES INSTALL INSTALL.ja LICENSE.txt NEWS \
		README README.ja

}
