# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.4.0-r2.ebuild,v 1.5 2002/08/16 04:09:22 murphy Exp $

inherit debug 
inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
SRC_URI="mirror://gnome/sources/ORBit2/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"


RDEPEND=">=dev-libs/glib-2.0.4-r1
		>=dev-libs/popt-1.6.3
		>=dev-libs/libIDL-0.7.4
		>=net-libs/linc-0.5.0-r2"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	elibtoolize
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
