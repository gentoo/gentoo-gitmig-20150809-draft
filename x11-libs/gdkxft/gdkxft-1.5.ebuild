# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gdkxft/gdkxft-1.5.ebuild,v 1.8 2003/02/13 16:55:58 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gdkxft transparently adds anti-aliased font support to gtk+-1.2."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gdkxft.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

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
