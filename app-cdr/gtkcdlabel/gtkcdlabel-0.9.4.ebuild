# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-0.9.4.ebuild,v 1.2 2004/03/12 12:02:37 mr_bones_ Exp $

DESCRIPTION="A GTK+ frontend to cdlabelgen for easy and fast cd cover creation"
HOMEPAGE="http://gtkcdlabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkcdlabel/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

RDEPEND=">=app-cdr/cdlabelgen-2.3.0
	>=media-libs/libcdaudio-0.99.6
	>=x11-libs/gtk+-2
	>=dev-util/glade-2
	>=gnome-base/libgnomeui-2*"

src_compile() {
	econf || die
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dodoc AUTHORS ChangeLog NEWS README
}
