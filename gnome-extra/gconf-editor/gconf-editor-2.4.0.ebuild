# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-2.4.0.ebuild,v 1.14 2004/07/14 15:24:13 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="An editor to the GNOME 2 config system"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips"
IUSE=""

RDEPEND=">=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2.0.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix gtk+-2.4 build
	epatch ${FILESDIR}/${P}-gtk+-2.4.patch

}
