# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsoundtouch/libsoundtouch-1.3.1.ebuild,v 1.5 2007/03/30 19:41:15 grobian Exp $

inherit autotools toolchain-funcs

IUSE="static sse"

MY_P="${P/lib}"

DESCRIPTION="Audio processing library for changing tempo, pitch and playback rates."
HOMEPAGE="http://www.surina.net/soundtouch/"
SRC_URI="http://www.surina.net/soundtouch/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if [[ $(tc-arch) == "x86" ]] && ! use sse; then
		eerror "You asked not to use SSE, but this package cannot be compiled on"
		eerror "your architecture without those instructions enabled."
		die "We're sorry, but you cannot use this package without SSE."
	fi
}

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
	rm -f ${D}/usr/share/doc/${PF}/COPYING.TXT	# remove obsolete LICENCE file
}
