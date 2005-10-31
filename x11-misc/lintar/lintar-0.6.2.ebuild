# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lintar/lintar-0.6.2.ebuild,v 1.2 2005/10/31 16:28:26 nelchael Exp $

IUSE=""
DESCRIPTION="A decompressing tool written in GTK+."
HOMEPAGE="http://lintar.sourceforge.net/"
SRC_URI="mirror://sourceforge/lintar/lintar-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-2*
	=gnome-base/gnome-vfs-2*
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog README NEWS TODO
}
