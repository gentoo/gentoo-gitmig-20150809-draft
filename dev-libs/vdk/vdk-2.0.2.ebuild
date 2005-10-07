# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vdk/vdk-2.0.2.ebuild,v 1.9 2005/10/07 18:01:45 flameeyes Exp $

inherit eutils

DESCRIPTION="The Visual Development Kit used by VDK Builder"
SRC_URI="mirror://sourceforge/vdkbuilder/${P}.tar.gz"
HOMEPAGE="http://vdkbuilder.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls gnome"

DEPEND="dev-libs/atk
	x11-libs/pango
	dev-libs/glib
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.0.3
	gnome? ( gnome-base/libgnome )"
#	app-doc/doxygen"

src_compile() {
	epatch ${FILESDIR}/${P}-makefile.in.patch

	econf \
		`use_enable nls` \
		`use_enable gnome` \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO
}
