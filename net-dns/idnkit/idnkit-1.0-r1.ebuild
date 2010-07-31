# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0-r1.ebuild,v 1.6 2010/07/31 20:22:52 armin76 Exp $

EAPI="2"

inherit autotools eutils fixheadtails

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

LICENSE="JNIC"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE=""

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

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog DISTFILES NEWS README README.ja
}
