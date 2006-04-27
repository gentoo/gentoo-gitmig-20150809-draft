# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glosung/glosung-2.1.3.ebuild,v 1.1 2006/04/27 14:37:56 squinky86 Exp $

DESCRIPTION="watch word program for the GNOME2 desktop (watch word (german): losung)"
HOMEPAGE="http://www.godehardt.org/losung.html"
SRC_URI="http://www.godehardt.org/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

RDEPEND=">=gnome-base/gconf-2.0
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND=">=dev-util/scons-0.93
	dev-util/pkgconfig
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.10
	${RDEPEND}"

src_compile() {
	scons ${MAKEOPTS} || die
}

src_install() {
	scons install DESTDIR=${D} || die
}
