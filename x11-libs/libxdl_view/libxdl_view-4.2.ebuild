# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxdl_view/libxdl_view-4.2.ebuild,v 1.2 2010/03/29 19:47:18 jlec Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="An X-Windows Based Toolkit"
HOMEPAGE="http://www.ccp4.ac.uk/dist/x-windows/xdl_view/doc/xdl_view_top.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE=""
RDEPEND="x11-libs/libXt"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/4.2-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
