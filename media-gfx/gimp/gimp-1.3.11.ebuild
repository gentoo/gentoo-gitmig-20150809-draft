# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.11.ebuild,v 1.5 2003/02/25 21:30:12 mholzer Exp $

IUSE="doc python"

inherit debug flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="1.4"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

replace-flags -Os -O2

#libglade
RDEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/glib-2.0.0
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b-r2
	>=media-libs/tiff-3.5.7
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-devel/gettext
	python? ( >=dev-lang/python-2.2 
	>=dev-python/pygtk-1.99.13 ) "


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"

	use python \
		&& myconf="${myconf} --enable-python" \
		|| myconf="${myconf} --disable-python"

	myconf="${myconf} --disable-print"

	econf --disable-perl ${myconf} --without-gnome-desktop || die
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


pkg_postinst() {
	ewarn "There have been changes to the gtkrc file."
	ewarn "You are strongly advised to remove the ~/.gimp-1.3 directory and perform a fresh"
	ewarn "user installation if you have been running a gimp-1.3 below minor version 11"
}
