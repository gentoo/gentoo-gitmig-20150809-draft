# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-0.1.ebuild,v 1.1 2002/11/07 06:21:42 leonardop Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="Gnome 2 Accessibility themes"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
LICENSE="as-is"

DEPEND=""
RDEPEND="gnome-base/gnome-desktop"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
