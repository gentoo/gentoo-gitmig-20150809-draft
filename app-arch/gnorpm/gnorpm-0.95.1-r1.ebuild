# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/gnorpm/gnorpm-0.95.1-r1.ebuild,v 1.10 2002/07/25 14:16:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gnome RPM Frontend"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=sys-libs/db-3.2.3h
	>=gnome-base/libghttp-1.0.9-r1
	>=app-arch/rpm-3.0.5"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --disable-rpmfind  || die
	make || die # Doesn't work with make -j 4 (hallski)
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
