# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-0.5.0.ebuild,v 1.3 2002/07/25 04:11:01 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="GAIL libraries for Gnome2 "
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="LGPL-2"

rdepenD=">=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-extra/at-spi-0.0.8
	>=dev-libs/atk-1.0.0
	>=gnome-base/gnome-common-1.2.4-r1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"


src_compile() {
	local myconf

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
# 	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO.xml
}





