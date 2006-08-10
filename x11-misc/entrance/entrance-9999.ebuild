# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-9999.ebuild,v 1.8 2006/08/10 23:36:36 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://xcomputerman.com/pages/entrance.html"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.de/gentoo/distfiles/extraicons-1.tar.bz2"
#	http://www.atmos.org/files/gentooed-src.tar.gz"

IUSE="pam"

RDEPEND="|| ( x11-libs/libXau virtual/x11 )
	pam? ( sys-libs/pam )
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9
	>=media-libs/edje-0.5.0
	>=x11-libs/esmart-0.9.0"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11	)"

src_unpack() {
	enlightenment_src_unpack
	if [ -d gentooed ] ; then
		mv gentooed "${S}"/data/themes/
		cd "${S}"/data/themes
		sed -i '/^SUBDIRS/s:$: gentooed:' Makefile.am
		cp default/{Makefile.am,build_theme.sh} gentooed/
		cd gentooed
		ln -s images img
		sed -i 's:default:gentooed:g' Makefile.am build_theme.sh
		sed -i 's:\(data/themes/default/Makefile\):\1 data/themes/gentooed/Makefile:' "${S}"/configure.in
	fi
}

src_compile() {
	if use pam ; then
		export MY_ECONF="--with-auth-mode=pam"
	else
		export MY_ECONF="--with-auth-mode=shadow"
	fi
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	use pam || rm -r "${D}"/etc/pam.d
	rm -rf "${D}"/etc/init.d
	insinto /usr/share/entrance/images/sessions
	doins "${WORKDIR}"/extraicons/*
	exeinto /usr/share/entrance
	doexe data/config/build_config.sh
}
