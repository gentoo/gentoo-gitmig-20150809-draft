# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-thinice/gtk-engines-thinice-1.0.4-r1.ebuild,v 1.7 2006/02/02 17:18:44 blubb Exp $

MY_P="gtk-thinice-theme-${PV}"
DESCRIPTION="Thinice theme engine for GTK+ 1"
SRC_URI="mirror://sourceforge/thinice/${MY_P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net/"

KEYWORDS="alpha amd64 hppa ppc sparc x86"
SLOT="1"
LICENSE="GPL-2"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README TODO
}
