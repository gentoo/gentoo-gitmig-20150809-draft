# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/zapping/zapping-0.6.4-r1.ebuild,v 1.2 2003/12/15 23:53:03 mholzer Exp $

DESCRIPTION="TV- and VBI- viewer for the Gnome environment"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://zapping.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls pam X"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	<gnome-base/libglade-0.99.0
	=x11-libs/gtk+-1.2*
	>=dev-libs/libunicode-0.4
	>=dev-libs/libxml-1.4.0
	>=sys-devel/gettext-0.10.36
	>=media-libs/gdk-pixbuf-0.8
	>=media-libs/zvbi-0.2
	>=media-libs/rte-0.4"

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use pam && myconf="${myconf} --enable-pam"
	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	econf ${myconf}

	mv src/Makefile src/Makefile.orig
	sed -e "s:\(INCLUDES = \$(COMMON_INCLUDES)\):\1 -I/usr/include/libglade-1.0 -I/usr/include/gdk-pixbuf-1.0:" \
		src/Makefile.orig > src/Makefile
	make || die "make failed"
}

src_install() {
	einstall \
		PACKAGE_LIB_DIR=${D}/usr/lib/zapping \
		PACKAGE_PIXMAPS_DIR=${D}/usr/share/pixmaps/zapping \
		PLUGIN_DEFAULT_DIR=${D}/usr/lib/zapping/plugins

	rm ${D}/usr/bin/zapzilla
	dosym /usr/bin/zapping /usr/bin/zapzilla
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
