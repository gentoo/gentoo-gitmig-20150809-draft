# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider <spider@gentoo.org>
# Maintainer: Spider  <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.4.0.ebuild,v 1.1 2002/05/28 00:44:05 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"
LICENSE="GPL-2"
SLOT="2"


S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/ORBit2/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"


RDEPEND=">=dev-libs/glib-2.0.0
		>=dev-libs/popt-1.6.3
		>=dev-libs/libIDL-0.7.4
		>=net-libs/linc-0.5.0"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"
src_compile() {
	local myconf
#	libtoolize --copy --force

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--mandir=/usr/share/man \
		--enable-debug=yes ${myconf} || die "failed in configure"
	emake || make || die "emake and make failed both. WHINE"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
    
	dodoc AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS
}
