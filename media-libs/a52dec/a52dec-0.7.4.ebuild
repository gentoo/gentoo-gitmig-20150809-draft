# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4.ebuild,v 1.14 2004/03/20 09:25:10 eradicator Exp $

inherit flag-o-matic

DESCRIPTION="library for decoding ATSC A/52 streams used in DVD"
HOMEPAGE="http://liba52.sourceforge.net/"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="oss static"

DEPEND=">=sys-devel/autoconf-2.52d-r1"
RDEPEND="virtual/glibc"

src_compile() {
	append-flags -fPIC
	filter-flags -fprefetch-loop-arrays

	local myconf
	use oss \
		|| myconf="${myconf} --disable-oss"
	use static \
		&& myconf="${myconf} --disable-shared --enable-static" \
		|| myconf="${myconf} --enable-shared --disable-static"

	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF}/html || die
	dodoc AUTHORS ChangeLog HISTORY NEWS README TODO doc/liba52.txt
}
