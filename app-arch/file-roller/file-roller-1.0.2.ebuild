# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-1.0.2.ebuild,v 1.14 2003/02/28 23:06:03 vapier Exp $

DESCRIPTION="archive manager for the GNOME environment"
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.4
	=gnome-base/gnome-vfs-1*
	=gnome-base/libglade-0*
	>=gnome-base/oaf-0.6.8
	>=gnome-base/bonobo-1.0.19
	>=media-libs/gdk-pixbuf-0.16.0"
RDEPEND="${DEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
