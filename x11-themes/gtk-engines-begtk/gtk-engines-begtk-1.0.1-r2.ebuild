# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-begtk/gtk-engines-begtk-1.0.1-r2.ebuild,v 1.1 2005/08/02 06:07:31 leonardop Exp $

DESCRIPTION="GTK+1 BeGTK Theme Engine"
SRC_URI="mirror://debian/pool/main/b/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/gtkbe/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="static"
SLOT="1"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/GTKBeEngine

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS README
}
