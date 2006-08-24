# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsoundtouch/libsoundtouch-1.3.1.ebuild,v 1.1 2006/08/24 06:20:53 dberkholz Exp $

inherit autotools

IUSE="static"

MY_P="${P/lib}"

DESCRIPTION="Audio processing library for changing tempo, pitch and playback rates."
HOMEPAGE="http://www.surina.net/soundtouch/"
SRC_URI="http://www.surina.net/soundtouch/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos"

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-respect-cflags.patch
	eautoreconf
}

src_compile() {
	econf $myconf \
		$(use_enable static) \
		--disable-integer-samples \
		--with-pic || die "./configure failed"
	# fixes C(XX)FLAGS from configure, so we can use *ours*
	emake CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" pkgdocdir="/usr/share/doc/${PF}" install || die
	rm -f ${D}/usr/share/doc/${PF}/COPYING.TXT  # remove obsolete LICENCE file
}
