# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/zapping/zapping-0.7.ebuild,v 1.3 2004/11/30 22:09:42 swegener Exp $

DESCRIPTION="TV- and VBI- viewer for the Gnome environment"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="nls pam X"

DEPEND=">=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gconf-2.4
	>=x11-libs/gtk+-2.0.0
	dev-libs/libxml2
	>=sys-devel/gettext-0.10.36
	>=media-libs/zvbi-0.2
	>=media-libs/rte-0.5.2"

src_compile() {
	local myconf

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	econf `use_enable nls` \
		`use_enable pam` \
		${myconf} || die "econf failed"

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
	# thx to Andreas Kotowicz <koto@mynetix.de> for mailing me this fix:
	rm ${D}/usr/bin/zapping_setup_fb
	dobin zapping_setup_fb/zapping_setup_fb
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
