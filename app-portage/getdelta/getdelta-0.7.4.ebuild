# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/getdelta/getdelta-0.7.4.ebuild,v 1.1 2006/09/09 13:58:18 genstef Exp $

DESCRIPTION="dynamic deltup client"
HOMEPAGE="http://linux01.gwdg.de/~nlissne/"
SRC_URI="http://linux01.gwdg.de/~nlissne/${P}.tar.bz2"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

RDEPEND="app-portage/deltup
	dev-util/bdelta"

src_install () {
	dobin ${WORKDIR}/getdelta.sh
}

pkg_postinst() {
	einfo "You need to put"
	einfo "FETCHCOMMAND=\"/usr/bin/getdelta.sh \\\${URI}\""
	einfo "into your /etc/make.conf to make use of getdelta"

	# make sure permissions are ok
	touch ${ROOT}/var/log/getdelta.log
	mkdir -p ${ROOT}/etc/deltup
	chown -R portage:portage ${ROOT}/{var/log/getdelta.log,etc/deltup}
	chmod -R ug+rwX ${ROOT}/{var/log/getdelta.log,etc/deltup}
}
