# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0-r2.ebuild,v 1.1 2011/10/11 15:18:36 jer Exp $

EAPI="4"

inherit autotools autotools-utils eutils fixheadtails

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

LICENSE="JNIC"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs"

DEPEND="sys-libs/glibc"
# non gnu systems need libiconv

S=${WORKDIR}/${P}-src

src_prepare() {
	ht_fix_all
	# Bug 263135, old broken libtool bundled
	rm -f aclocal.m4 || die "rm failed"
	epatch "${FILESDIR}/${P}-autotools.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || remove_libtool_files
	dodoc ChangeLog DISTFILES NEWS README README.ja
}
