# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-2.4.0.2.ebuild,v 1.10 2004/04/08 00:50:23 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa amd64 ia64"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/gnome-vfs-2.2
	virtual/ghostscript
	dev-libs/popt"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog INSTALL MAINTAINERS TODO README"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix build with gtk+-2.4
	epatch ${FILESDIR}/${PN}-2.4-fix_gtk+-2.4_build.patch
}
