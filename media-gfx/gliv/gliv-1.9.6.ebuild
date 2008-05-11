# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.9.6.ebuild,v 1.5 2008/05/11 19:59:58 maekke Exp $

DESCRIPTION="An image viewer that uses OpenGL"
HOMEPAGE="http://guichaz.free.fr/gliv/"
SRC_URI="http://guichaz.free.fr/gliv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.6
		virtual/opengl
		>x11-libs/gtkglext-1.0.6
		nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		>=sys-devel/bison-1.875"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	# Needed if desktop-file-install is present, else we get
	# sandbox violations.
	export DESKTOP_FILE_INSTALL_DIR="${D}/usr/share/applications"

	einstall || die "make install failed"
	dodoc README NEWS THANKS
}
