# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

DESCRIPTION="Downloader for X, a download manager"
HOMEPAGE="http://www.krasu.ru/soft/chuchelo/"
SRC_URI="http://www.krasu.ru/soft/chuchelo/files/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	>=sys-devel/gettext-0.10.39
	>=media-libs/gdk-pixbuf-0.18.0
	>=x11-libs/gtk+-2.0.5"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.6
	>=sys-devel/autoconf-2.52"

S="${WORKDIR}/${P}"

src_compile() {
#	patch -p0 < ${FILESDIR}/d4x.patch
#	econf || die
#	patch -p0 < ${FILESDIR}/makefile.patch
#
#	make || die
#	patch -p0 < ${FILESDIR}/makefile2.patch

	econf || die "configure problem"
	cd share
	mv Makefile Makefile.orig
	sed <Makefile.orig >Makefile \
		-e "s|datadir = /usr/share|datadir = ${D}/usr/share|"
	cd ..
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"

	dodoc AUTHORS COPYING ChangeLog NEWS PLANS TODO
}
