# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-9999.ebuild,v 1.1 2004/10/21 20:38:02 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://xcomputerman.com/pages/entrance.html"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.de/gentoo/distfiles/extraicons-1.tar.bz2"
#	http://www.atmos.org/files/gentooed-src.tar.gz"

IUSE="pam"

DEPEND="virtual/x11
	pam? ( sys-libs/pam )
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-1.0.0_pre13
	>=x11-libs/ecore-1.0.0_pre7
	>=media-libs/edje-0.5.0
	>=x11-libs/esmart-0.0.2.20040501
	>=sys-apps/sed-4"

src_unpack() {
	enlightenment_src_unpack
	if [ -d gentooed ] ; then
		mv gentooed ${S}/data/themes/
		cd ${S}/data/themes
		sed -i '/^SUBDIRS/s:$: gentooed:' Makefile.am
		cp default/{Makefile.am,build_theme.sh} gentooed/
		cd gentooed
		ln -s images img
		sed -i 's:default:gentooed:g' Makefile.am build_theme.sh
		sed -i 's:\(data/themes/default/Makefile\):\1 data/themes/gentooed/Makefile:' ${S}/configure.in
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
	rm -rf ${D}/etc/init.d
	insinto /usr/share/entrance/images/sessions
	doins ${WORKDIR}/extraicons/*
	exeinto /usr/share/entrance
	doexe data/config/build_config.sh

	cd /etc/X11/Sessions
	local edb="${D}/etc/entrance_config.db"
	local count="`edb_ed ${edb} get /entrance/session/count int`"
	local datadir="${D}/usr/share/entrance/images/sessions"
	local icon=""
	while [ ${count} -ge 0 ] ; do
		edb_ed ${edb} del /entrance/session/${count}/icon
		edb_ed ${edb} del /entrance/session/${count}/session
		edb_ed ${edb} del /entrance/session/${count}/title
		count=$((${count} - 1))
	done
	count=0
	for s in default * failsafe ; do
		[ "${s}" == "Xsession" ] && continue
		icon="`find ${datadir} -iname ${s}.png -printf %f`"
		if [ -z "${icon}" ] ; then
			edb_ed ${edb} add /entrance/session/${count}/icon str default.png
		else
			edb_ed ${edb} add /entrance/session/${count}/icon str ${icon}
		fi
		edb_ed ${edb} add /entrance/session/${count}/session str ${s}
		edb_ed ${edb} add /entrance/session/${count}/title str ${s}
		count=$((${count} + 1))
	done
	edb_ed ${edb} add /entrance/session/count int ${count}
}
