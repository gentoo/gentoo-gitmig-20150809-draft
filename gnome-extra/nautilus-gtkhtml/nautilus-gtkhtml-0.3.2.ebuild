# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-gtkhtml/nautilus-gtkhtml-0.3.2.ebuild,v 1.2 2002/07/11 06:30:26 drobbins Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="libgtkhtml addons for Nautilus in gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"


RDEPEND=">=gnome-base/nautilus-1.1.10
	>=gnome-extra/libgtkhtml-1.99.7"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"


src_compile() {
	local myconf

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc ABOUT-NLS  AUTHORS COPYING  ChangeLog  INSTALL NEWS  README TODO
}





