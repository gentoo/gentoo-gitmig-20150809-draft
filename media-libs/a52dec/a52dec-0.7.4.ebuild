# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4.ebuild,v 1.10 2003/11/04 23:17:55 mr_bones_ Exp $

DESCRIPTION="A  free library for decoding ATSC A/52 streams used in DVD, etc with a test program"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://liba52.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
IUSE="oss static"
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=sys-devel/autoconf-2.52d-r1"

src_compile() {

	local myconf
	export CFLAGS="${CFLAGS} -fPIC"
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
	dodoc AUTHORS ChangeLog HISTORY NEWS README TODO doc/liba52.txt || \
		die "dodoc failed"
}
