# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxklavier/libxklavier-5.1.ebuild,v 1.5 2011/12/26 12:20:27 maekke Exp $

EAPI="3"
inherit gnome.org eutils libtool multilib

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND="x11-misc/xkeyboard-config
	x11-libs/libX11
	>=x11-libs/libXi-1.1.3
	x11-apps/xkbcomp
	x11-libs/libxkbfile
	>=dev-libs/glib-2.16:2
	dev-libs/libxml2
	app-text/iso-codes"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.4 )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--with-xkb-base="${EPREFIX}/usr/share/X11/xkb" \
		--with-xkb-bin-base="${EPREFIX}/usr/bin" \
		$(use_enable doc gtk-doc)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog CREDITS NEWS README || die

	# Remove unnecessary la files
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libxklavier.so.15
}
