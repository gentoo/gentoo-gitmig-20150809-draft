# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

S=${WORKDIR}/${P}
DESCRIPTION="Gdkxft transparently adds anti-aliased font support to gtk+-1.2."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gdkxft.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2*
	virtual/x11
	=gnome-base/control-center-1.4*"

src_compile() {
	CPPFLAGS=-I/usr/include/libcapplet1 ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failure"
}

pkg_postinst () {
	/usr/sbin/gdkxft_sysinstall || die "installation of gdkfxt failed"

}

pkg_prerm () {
	/usr/sbin/gdkxft_sysinstall -u || die "uninstall failed"
}
