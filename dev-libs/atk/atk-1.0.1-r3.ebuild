# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.0.1-r3.ebuild,v 1.2 2002/07/11 06:30:20 drobbins Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


SLOT="1"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://developer.gnome.org/projects/gap/"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-libs/glib-2.0.1"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	libtoolize --copy --force
	local myconf
	 use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	 
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
		--enable-debug || die

## Since glib fails with debug, we debug here too

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS 
}

