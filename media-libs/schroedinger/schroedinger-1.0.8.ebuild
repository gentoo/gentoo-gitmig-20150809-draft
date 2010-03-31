# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-1.0.8.ebuild,v 1.10 2010/03/31 12:27:43 ssuominen Exp $

EAPI=3
inherit libtool

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://www.diracvideo.org"
SRC_URI="http://www.diracvideo.org/download/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/liboil-0.3.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS TODO
}
