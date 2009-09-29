# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/spcaview/spcaview-20071224.ebuild,v 1.1 2009/09/29 11:14:22 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="A webcam viewer for the spca5xx driver"
HOMEPAGE="http://mxhaard.free.fr/sview.html"
SRC_URI="http://mxhaard.free.fr/spca50x/Download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	dobin spca{view,serv,cat} || die
	dodoc Changelog README
}
