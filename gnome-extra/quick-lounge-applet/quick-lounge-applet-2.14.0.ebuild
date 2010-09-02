# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/quick-lounge-applet/quick-lounge-applet-2.14.0.ebuild,v 1.7 2010/09/02 20:42:44 pacho Exp $

EAPI="2"

inherit autotools gnome2 eutils

DESCRIPTION="Application launcher applet for GNOME"
HOMEPAGE="http://quick-lounge.sourceforge.net/"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.14
	>=gnome-base/gconf-2.0
	>=gnome-base/gnome-panel-2.4
	>=gnome-base/gnome-menus-2.12
	sys-devel/gettext"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0
	app-text/gnome-doc-utils"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_prepare() {
	gnome2_src_prepare

	# Make this gmake-3.82 compliant, bug #333643
	epatch "${FILESDIR}/${P}-fix-make-3.82.patch"

	# Fix broken intltool used in tarball
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
