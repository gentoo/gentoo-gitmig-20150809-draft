# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.15.9-r1.ebuild,v 1.2 2010/07/20 01:54:53 jer Exp $

inherit eutils gnome2 virtualx

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.11.1
	>=x11-libs/gtk+-2.6"

# FIXME: need libcolorblind (debian package)
# python deps are for applets
#	applet? (
#		>=dev-python/pygtk-2.6
#		dev-python/pygobject
#
#		>=dev-python/libbonobo-python-2.10
#		>=dev-python/gconf-python-2.10
#		>=dev-python/libgnome-python-2.10
#		>=dev-python/gnome-applets-python-2.10 )

RDEPEND="${RDEPEND}
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2.3.100

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXcomposite"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35

	x11-proto/xextproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"

#pkg_setup() {
#	G2CONF="${G2CONF} $(use_enable applet colorblind-applet)"
#}

src_unpack() {
	gnome2_src_unpack

	# Fix some ugly warnings, originally per upstream bug #578798
	epatch "${FILESDIR}/${P}-magnifier-fix-warnings.patch"
}

src_test() {
	Xemake check || die "emake check failed"

}
