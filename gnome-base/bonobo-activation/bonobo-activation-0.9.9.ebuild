# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo-activation/bonobo-activation-0.9.9.ebuild,v 1.1 2002/05/23 19:15:17 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="This is the Gnome2 replacement of OAF"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.0
	>=dev-libs/libxml2-2.4.16
	>=dev-libs/popt-1.6.3
	>=gnome-base/ORBit2-2.3.106-r1"

DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 
		>=app-text/openjade-1.3 )"

src_compile() {
	libtoolize --copy --force 
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			--localstatedir=/var/lib \
			${myconf} \
			--enable-debug=yes || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
    
 	dodoc AUTHORS  ABOUT-NLS COPYING* ChangeLog  README* INSTALL NEWS TODO docs/* api-docs/*
}





