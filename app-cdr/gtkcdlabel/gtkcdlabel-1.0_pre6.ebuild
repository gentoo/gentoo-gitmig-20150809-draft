# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-1.0_pre6.ebuild,v 1.6 2005/03/27 00:42:06 hansmi Exp $

MY_P=${P/_}
DESCRIPTION="A GTK+ frontend to cdlabelgen for easy and fast cd cover creation"
HOMEPAGE="http://gtkcdlabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkcdlabel/${MY_P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc"

RDEPEND=">=app-cdr/cdlabelgen-2.3.0
	>=media-libs/libcdaudio-0.99.6
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2*"

DEPEND="${RDEPEND}
	sys-apps/gawk
	dev-util/pkgconfig
	sys-devel/gcc"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dodoc AUTHORS ChangeLog README
}
