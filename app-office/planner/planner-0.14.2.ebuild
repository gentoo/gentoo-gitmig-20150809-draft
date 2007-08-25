# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/planner/planner-0.14.2.ebuild,v 1.5 2007/08/25 09:50:10 eva Exp $

inherit gnome2 fdo-mime

DESCRIPTION="Project manager for Gnome2"
HOMEPAGE="http://live.gnome.org/Planner/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ppc sparc x86"
IUSE="doc libgda python examples"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnomecanvas-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/libglade-2.4
	>=gnome-base/gnome-vfs-2.10
	>=gnome-base/libgnomeprintui-2.10
	>=gnome-base/gconf-2.6
	>=dev-libs/libxml2-2.6
	>=dev-libs/libxslt-1.1
	libgda? ( =gnome-extra/libgda-1* )
	python? ( >=dev-python/pygtk-2.6 )"
# disable eds backend for now, its experimental
#	eds? ( >=gnome-extra/evolution-data-server-1.1 )"
#		>=mail-client/evolution-2.1.3 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	app-text/scrollkeeper
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-0.10 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL README"

# darn thing breaks in paralell make :/
MAKEOPTS="${MAKEOPTS} -j1"

G2CONF="${G2CONF} \
	$(use_enable libgda database) \
	$(use_enable python) \
	$(use_enable python python-plugin) \
	--disable-update-mimedb"
#	$(use_enable eds) \
#	$(use_enable eds eds-backend) \

src_install() {
	local myinstall="sqldocdir=\"\$(datadir)/doc/${PF}\""

	if use examples; then
		myinstall="${myinstall} sampledir=\"\$(datadir)/doc/${PF}/examples\""
	fi

	gnome2_src_install ${myinstall}
}
