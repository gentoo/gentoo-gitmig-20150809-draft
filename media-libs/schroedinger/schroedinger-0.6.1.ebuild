# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-0.6.1.ebuild,v 1.2 2007/10/01 02:24:14 mr_bones_ Exp $

inherit autotools eutils

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://schrodinger.sourceforge.net"
SRC_URI="mirror://sourceforge/schrodinger/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gstreamer test"

RDEPEND=">=dev-libs/liboil-0.3.12
	gstreamer? ( >=media-libs/gst-plugins-base-0.10 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )
	test? ( >=dev-libs/check-0.9.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf $(use_enable gstreamer)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog NEWS TODO
}
