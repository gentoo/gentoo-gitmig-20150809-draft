# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/spandsp/spandsp-0.0.2_pre4.ebuild,v 1.1 2004/11/10 14:48:51 gustavoz Exp $

inherit eutils

IUSE=""

DESCRIPTION="SpanDSP is a library of DSP functions for telephony."
HOMEPAGE="http://www.opencall.org/"

S="${WORKDIR}/${PN}-0.0.2"
SRC_URI="ftp://ftp.opencall.org/pub/spandsp/${P/_/}/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-libs/audiofile-0.2.6-r1
		>=media-libs/tiff-3.5.7-r1"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}
