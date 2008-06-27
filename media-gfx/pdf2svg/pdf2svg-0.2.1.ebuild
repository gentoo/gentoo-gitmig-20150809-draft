# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pdf2svg/pdf2svg-0.2.1.ebuild,v 1.1 2008/06/27 13:05:44 drac Exp $

inherit eutils

DESCRIPTION="pdf2svg is based on poppler and cairo and can convert pdf to svg files"
HOMEPAGE="http://www.cityinthesky.co.uk/pdf2svg.html"
SRC_URI="http://www.cityinthesky.co.uk/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-text/poppler-0.5.4
	>=x11-libs/cairo-1.2.6
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use x11-libs/cairo svg; then
		die "Re-emerge x11-libs/cairo with USE svg."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e \
		's:#include <stdio.h>:#include <stdio.h>\n#include <stdlib.h>:' \
		${PN}.c || die "sed failed."
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
