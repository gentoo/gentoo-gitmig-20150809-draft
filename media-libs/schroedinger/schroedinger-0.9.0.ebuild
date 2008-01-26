# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-0.9.0.ebuild,v 1.1 2008/01/26 08:35:04 drac Exp $

inherit eutils

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://schrodinger.sourceforge.net"
SRC_URI="mirror://sourceforge/schrodinger/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gstreamer test"

RDEPEND=">=dev-libs/liboil-0.3.12
	gstreamer? ( >=media-libs/gst-plugins-base-0.10 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( >=dev-libs/check-0.9.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Patch Makefile.in instead of Makefile.am to avoid
	# the need for .m4 macro from gtk-doc wrt #205755.
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	econf --disable-gtk-doc $(use_enable gstreamer)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog NEWS TODO
}
