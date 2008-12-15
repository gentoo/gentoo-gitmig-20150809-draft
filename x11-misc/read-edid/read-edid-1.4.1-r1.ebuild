# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/read-edid/read-edid-1.4.1-r1.ebuild,v 1.10 2008/12/15 04:09:24 yngwin Exp $

inherit autotools eutils

DESCRIPTION="Get EDID information from a pnp monitor"
HOMEPAGE="http://john.fremlin.de/programs/linux/read-edid/index.html"
SRC_URI="http://john.fremlin.de/programs/linux/read-edid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-arch.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog LRMI NEWS README
}
