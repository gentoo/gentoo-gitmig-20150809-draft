# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxdl_view/libxdl_view-4.2-r1.ebuild,v 1.3 2011/01/20 14:39:53 hwoarang Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="An X-Windows Based Toolkit"
HOMEPAGE="http://www.ccp4.ac.uk/dist/x-windows/xdl_view/doc/xdl_view_top.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

IUSE=""
RDEPEND="x11-libs/libXt"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-impl-dec.patch \
		"${FILESDIR}"/${PV}-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
