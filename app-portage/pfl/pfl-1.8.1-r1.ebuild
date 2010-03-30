# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/pfl/pfl-1.8.1-r1.ebuild,v 1.2 2010/03/30 17:11:52 billie Exp $

PYTHON_DEPEND=2

inherit python multilib

DESCRIPTION="PFL is an online searchable file/package database for Gentoo"
HOMEPAGE="http://www.portagefilelist.de/index.php/Special:PFLQuery2"
SRC_URI="http://files.portagefilelist.de/${P}
	http://files.portagefilelist.de/e-file"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="network-cron"

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/curl
	sys-apps/portage"

RESTRICT="mirror"

src_unpack() {
	cp "${DISTDIR}/${P}" "${WORKDIR}/${PN}.py"
	cp "${DISTDIR}/e-file" "${WORKDIR}/e-file"
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	if use network-cron ; then
		cat >> "${T}/${PN}" <<- EOF
		#!/bin/sh
		exec nice $(PYTHON) -O $(python_get_sitedir)/${PN}/${PN}.py >/dev/null
		EOF

		exeinto /etc/cron.weekly
		doexe "${T}/${PN}" || die "install ${PN} cron file failed"
	fi

	exeinto $(python_get_sitedir)/${PN}
	doexe ${PN}.py || die "install ${PN}.py failed"

	dobin e-file || die "install e-file failed"

	dodir /var/lib/${PN} || die "directory creation failed"
	fowners 0:portage /var/lib/${PN}
	fperms 0775 /var/lib/${PN}
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}

	if [[ ! -e "${ROOT%/}/var/lib/${PN}/lastrun" ]]; then
		echo -n 0 > "${ROOT%/}/var/lib/${PN}/lastrun"
		chown -R 0:portage "${ROOT%/}/var/lib/${PN}"
		chmod -R 775 "${ROOT%/}/var/lib/${PN}"
	fi
}

pkg_postrm() {
	python_mod_cleanup
}
