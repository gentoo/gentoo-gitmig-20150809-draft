# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdts/libdts-0.0.2.ebuild,v 1.2 2004/04/08 07:05:48 eradicator Exp $

inherit flag-o-matic

DESCRIPTION="library for decoding DTS Coherent Acoustics streams used in DVD"
HOMEPAGE="http://www.videolan.org/dtsdec.html"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="oss debug"

DEPEND=">=sys-devel/autoconf-2.52d-r1"

src_compile() {
	append-flags -fPIC

	econf `use_enable oss` `use_enable debug` || die
	emake || die "emake failed"
}

src_install() {
	# fails in 0.0.2: make DESTDIR=${D} docdir=${D}/usr/share/doc/${PF}/html || die
	einstall docdir=${D}/usr/share/doc/${PF}/html || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/libdts.txt
}
