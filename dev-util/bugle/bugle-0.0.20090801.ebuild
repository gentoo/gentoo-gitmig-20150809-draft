# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bugle/bugle-0.0.20090801.ebuild,v 1.3 2011/03/23 16:50:55 ssuominen Exp $

EAPI="2"

inherit autotools eutils toolchain-funcs

DESCRIPTION="A tool for OpenGL debugging"
HOMEPAGE="http://www.opengl.org/sdk/tools/BuGLe/"
SRC_URI="mirror://sourceforge/bugle/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg gtk readline"

DEPEND="ffmpeg? ( >=media-video/ffmpeg-0.5 )
	gtk? ( x11-libs/gtk+:2 x11-libs/gtkglext )
	readline? ( sys-libs/readline )
	virtual/opengl
	media-libs/glew
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with ffmpeg lavc) \
		$(use_with readline) \
		$(use_with gtk) \
		$(use_with gtk gtkglext)
}

src_install() {
	dodoc README TODO NEWS doc/*.{txt,html} || die "dodoc failed"
	docinto examples
	dodoc doc/examples/* || die "dodoc failed"
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "See man 3 bugle for an introduction to BuGLe."
}
