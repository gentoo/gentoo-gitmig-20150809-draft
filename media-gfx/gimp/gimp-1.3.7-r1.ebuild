# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.7-r1.ebuild,v 1.2 2002/07/16 11:36:46 seemant Exp $


# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="1.4"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

#libglade
RDEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/glib-2.0.0
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b-r2
	>=media-libs/tiff-3.5.7
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-devel/gettext"
# Bah, circ dependency
#	cups? ( media-gfx/gimp-print )
	

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
# circular dependency
# 	use cups && myconf="${myconf} --enable-print" || myconf="${myconf} --disable-print"
	myconf="${myconf} --disable-print"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--disable-perl ${myconf} \
		--without-gnome-desktop \
		|| die
	# disable gnome-desktop since it breaks sandboxing

# hack for odd make break
	touch plug-ins/common/${P}.tar.bz2
	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		localstatedir=/var/lib \
		install || die
    
	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO* 

}


