# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-0.9.0.20040201.ebuild,v 1.1 2004/02/01 20:48:51 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://xcomputerman.com/pages/entrance.html"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.de/gentoo/distfiles/extraicons-1.tar.bz2"

IUSE="${IUSE} pam"

DEPEND="virtual/x11
	pam? ( sys-libs/pam )
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/evas-1.0.0.20031025_pre11
	>=x11-libs/ecore-0.0.2.20031018_pre4
	>=media-libs/edje-0.0.1.20031020
	>=x11-libs/esmart-0.0.2.20031025"

src_compile() {
	if [ `use pam` ] ; then
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
	for s in Default * failsafe ; do
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
