# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtksee/gtksee-0.5.6.ebuild,v 1.1 2004/07/19 10:27:17 mr_bones_ Exp $

DESCRIPTION="A simple but functional image viewer/browser - ACD See alike."
HOMEPAGE="http://gtksee.berlios.de/"
SRC_URI="http://download.berlios.de/gtksee/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/jpeg
	media-libs/tiff
	>=media-libs/libpng-1.2.1
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO || die "dodoc failed"
}
