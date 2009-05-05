# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/totem-pl-parser/totem-pl-parser-2.26.1.ebuild,v 1.3 2009/05/05 13:25:23 nirbheek Exp $

EAPI="2"

GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Playlist parsing library"
HOMEPAGE="http://www.gnome.org/projects/totem/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc hal test"

RDEPEND=">=dev-libs/glib-2.17.3
	>=x11-libs/gtk+-2.12
	>=gnome-extra/evolution-data-server-1.12"
DEPEND="${RDEPEND}
	!<media-video/totem-2.21
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.11 )"

G2CONF="${G2CONF} --disable-static"

src_prepare() {
	gnome2_src_prepare

	# Conditional patching is purely to avoid eautoreconf
	if use test && ! use doc; then
		epatch "${FILESDIR}/${P}-fix-tests-without-gtk-doc.patch"
		eautoreconf
	fi
}

src_install() {
	if use test && ! use doc; then
		# Weird bug with empty GTKDOC_REBASE because of above patch
		local gtkdoc_rebase="! which gtkdoc-rebase >/dev/null 2>&1 || gtkdoc-rebase"
		emake DESTDIR="${D}" GTKDOC_REBASE="${gtkdoc_rebase}" install || die "install failed"
	else
		emake DESTDIR="${D}" install || die "install failed"
	fi
}
