# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gnorpm/gnorpm-0.95.1-r1.ebuild,v 1.17 2003/07/01 20:36:34 aliz Exp $

DESCRIPTION="A Gnome RPM Frontend"
SRC_URI="mirror://gnome//sources/gnorpm/${PV/.1}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE="nls"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=sys-libs/db-3.2.3h
	>=gnome-base/libghttp-1.0.9-r1
	>=app-arch/rpm-3.0.5"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --disable-rpmfind
	make || die # Doesn't work with make -j 4 (hallski)
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
