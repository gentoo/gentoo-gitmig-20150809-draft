# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-common/gnome-common-1.2.4-r3.ebuild,v 1.11 2003/07/20 00:29:22 tester Exp $


# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="Some Common files for Gnome2 applications"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/sources/${PN}/1.2/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

RDEPEND=">=dev-libs/glib-2.0.0"
DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "install failure"
    
 	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS 
}
