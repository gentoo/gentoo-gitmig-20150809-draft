# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.9.2.ebuild,v 1.1 2005/03/24 09:31:21 lu_zero Exp $

DESCRIPTION="An image viewer that uses OpenGL"
HOMEPAGE="http://guichaz.free.fr/gliv/"
SRC_URI="http://guichaz.free.fr/gliv/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.4
	virtual/opengl
	sys-devel/gettext
	>=sys-devel/bison-1.875
	>x11-libs/gtkglext-1.0.6
	nls? ( sys-devel/gettext )"

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
