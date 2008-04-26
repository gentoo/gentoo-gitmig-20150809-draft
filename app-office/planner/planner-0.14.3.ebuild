# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/planner/planner-0.14.3.ebuild,v 1.2 2008/04/26 16:50:46 eva Exp $

inherit autotools eutils gnome2

DESCRIPTION="Project manager for Gnome2"
HOMEPAGE="http://live.gnome.org/Planner/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="doc eds libgda python examples"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnomecanvas-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/libglade-2.4
	>=gnome-base/gnome-vfs-2.10
	>=gnome-base/libgnomeprintui-2.10
	>=gnome-base/gconf-2.6
	>=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.23
	libgda? ( =gnome-extra/libgda-1* )
	python? ( >=dev-python/pygtk-2.6 )
	eds? (
		>=gnome-extra/evolution-data-server-1.1
		>=mail-client/evolution-2.1.3 )"

# FIXME: update libgda dep when 3 is unmasked.
# disable eds backend for now, its experimental

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	  app-text/scrollkeeper
	>=dev-util/intltool-0.35.5
	  dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable libgda database)
		$(use_enable python)
		$(use_enable python python-plugin)
		$(use_enable eds)
		--disable-update-mimedb"
#		$(use_enable eds eds-backend)
}

src_unpack() {
	gnome2_src_unpack

	# Fix parallel build issues
	epatch "${FILESDIR}/${P}-parallel-build.patch"

	# Fix compile failure with eds-plugin
	epatch "${FILESDIR}/${P}-eds-plugin.patch"

	eautomake
	intltoolize --force || die "intltoolize failed"
}

src_install() {
	gnome2_src_install \
		sqldocdir="\$(datadir)/doc/${PF}" \
		sampledir="\$(datadir)/doc/${PF}/examples"

	if ! use examples; then
		rm -rf "${D}/usr/share/doc/${PF}/examples"
	fi
}
