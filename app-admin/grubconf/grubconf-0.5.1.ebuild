# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/grubconf/grubconf-0.5.1.ebuild,v 1.5 2004/08/22 16:46:25 robmoss Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome2 based GRUB configuration editor"
HOMEPAGE="http://grubconf.sourceforge.net/"
SRC_URI="mirror://sourceforge/grubconf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=app-text/scrollkeeper-0.3.11
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2"
DEPEND="${RDEPEND}
	sys-boot/grub
	>=dev-util/pkgconfig-0.12.0"

src_unpack() {
	unpack ${A}
	cd ${S}/po
	epatch ${FILESDIR}/Makefile.in.in.patch
}

src_compile() {
	econf --enable-splashimage
	emake
}
