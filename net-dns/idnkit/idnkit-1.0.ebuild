# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0.ebuild,v 1.10 2007/01/06 16:22:19 kloeri Exp $

S="${WORKDIR}/${P}-src"

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

SLOT="0"
LICENSE="JNIC"
KEYWORDS="~alpha ~amd64 ppc x86"
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
