# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tangerine-icon-theme/tangerine-icon-theme-0.27.ebuild,v 1.1 2010/04/02 15:27:30 ssuominen Exp $

EAPI=3
inherit gnome2-utils

DESCRIPTION="a derivative of the standard Tango theme, using a more orange approach"
HOMEPAGE="http://packages.ubuntu.com/gutsy/x11/tangerine-icon-theme"
SRC_URI="mirror://ubuntu/pool/universe/t/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( kde-base/oxygen-icons x11-themes/gnome-icon-theme )"
DEPEND=">=x11-misc/icon-naming-utils-0.8.90
	dev-util/intltool
	sys-devel/gettext"

RESTRICT="binchecks strip"

src_prepare() {
	sed -i \
		-e 's:lib/icon-naming-utils/icon:libexec/icon:' \
		Makefile || die
}

src_compile() {
	emake index.theme || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
