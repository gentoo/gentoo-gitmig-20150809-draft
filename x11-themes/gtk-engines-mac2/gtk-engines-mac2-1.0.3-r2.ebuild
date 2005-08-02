# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mac2/gtk-engines-mac2-1.0.3-r2.ebuild,v 1.1 2005/08/02 10:49:20 leonardop Exp $

DESCRIPTION="GTK+1 MacOS Look-alike Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/mac2/"
SRC_URI="http://download.freshmeat.net/themes/mac2/mac2-1.2.x.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
LICENSE="GPL-2"
SLOT="1"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/gtk-Mac2-theme

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS README
}
