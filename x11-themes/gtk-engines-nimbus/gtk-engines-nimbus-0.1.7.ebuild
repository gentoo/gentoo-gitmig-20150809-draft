# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-nimbus/gtk-engines-nimbus-0.1.7.ebuild,v 1.3 2012/05/05 04:10:07 jdhore Exp $

EAPI=4
AUTOTOOLS_AUTO_DEPEND=no
MY_P=nimbus-${PV}

inherit autotools gnome2-utils

DESCRIPTION="A GTK+-2 engine, icon and metacity themes from Sun JDS"
HOMEPAGE="http://dlc.sun.com/osol/jds/downloads/extras/nimbus/"
SRC_URI="http://dlc.sun.com/osol/jds/downloads/extras/nimbus/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.1
	virtual/pkgconfig
	dev-util/intltool
	kernel_Interix? ( ${AUTOTOOLS_DEPEND} )"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	echo light-index.theme.in >> po/POTFILES.skip
	echo dark-index.theme.in >> po/POTFILES.skip

	# Interix needs a full eautoreconf, but don't bother for other archs
	[[ ${CHOST} == *-interix* ]] && eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	find "${ED}"usr -name 'libnimbus.la' -exec rm -f {} +
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
