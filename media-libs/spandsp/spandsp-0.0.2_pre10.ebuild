# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/spandsp/spandsp-0.0.2_pre10.ebuild,v 1.1 2005/03/21 18:35:53 stkn Exp $

inherit eutils

IUSE=""

DESCRIPTION="SpanDSP is a library of DSP functions for telephony."
HOMEPAGE="http://www.soft-switch.org/"

S="${WORKDIR}/${PN}-0.0.2"
SRC_URI="ftp://ftp.soft-switch.org/pub/spandsp/${P/_/}/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

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
