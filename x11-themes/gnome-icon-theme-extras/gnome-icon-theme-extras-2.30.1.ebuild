# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme-extras/gnome-icon-theme-extras-2.30.1.ebuild,v 1.4 2012/05/05 04:10:06 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools gnome2

DESCRIPTION="GNOME 2 icon theme extras"
HOMEPAGE="http://www.gnome.org/ http://git.gnome.org/browse/gnome-icon-theme-extras/"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
# FIXME: double check potential LINGUAS problem
DOCS="AUTHORS README NEWS"
G2CONF="${G2CONF} --enable-icon-mapping"

src_prepare() {
	# Always use pre-rendered icons
	sed -e 's/"x$allow_rendering" = "xyes"/"x$allow_rendering" = "xdonotwant"/' \
		-i configure.ac -i configure || die
	# Avoid maintainer-mode
	eautoreconf

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	# FIXME: 2.30.1 tries to install icon-theme.cache, recheck if still needed
	# in future versions
	rm -f "${ED}/usr/share/icons/gnome/icon-theme.cache" || die
}
