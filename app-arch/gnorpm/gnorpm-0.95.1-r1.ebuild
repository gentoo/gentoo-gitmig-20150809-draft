# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="A Gnome RPM Frontend"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

RDEPEND="virtual/glibc
        >=gnome-base/gnome-libs-1.4.1.2-r1
	>=sys-libs/db-3.2.3h
	>=gnome-base/libghttp-1.0.9-r1
	>=app-arch/rpm-3.0.5"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --disable-rpmfind
	assert

	make || die # Doesn't work with make -j 4 (hallski)
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
