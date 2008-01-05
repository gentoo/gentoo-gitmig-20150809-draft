# Copyright 1999-2008 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glosung/glosung-3.2.1.ebuild,v 1.1 2008/01/05 18:16:05 beandog Exp $

DESCRIPTION="Watch word program for the GNOME2 desktop (watch word (german): losung)"
HOMEPAGE="http://www.godehardt.org/losung.html"
SRC_URI="mirror://sourceforge/glosung/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=gnome-base/gconf-2.0
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	net-misc/curl
	${DEPEND}"
DEPEND=">=dev-util/scons-0.93
	dev-util/pkgconfig
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.10"

src_compile() {
	scons ${MAKEOPTS} || die "scons make died"
}

src_install() {
	scons install DESTDIR="${D}" || die "scons install died"
}
