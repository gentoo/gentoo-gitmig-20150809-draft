# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gimps/gimps-23.5.ebuild,v 1.1 2004/01/23 16:20:13 spock Exp $

IUSE=""
DESCRIPTION="GIMPS - The Great Internet Mersenne Prime Search"
HOMEPAGE="http://mersenne.org/"
SRC_URI="ftp://mersenne.org/gimps/mprime235.tar.gz"

DEPEND=">=sys-apps/baselayout-1.8.0
	>=sys-libs/glibc-2.1"
SLOT="0"
#LICENSE="as-is"
KEYWORDS="~x86"

S="${WORKDIR}"
I="/opt/gimps"

src_install () {

	cd ${S}

	dodir ${I} /var/lib/gimps
	cp mprime ${D}/${I}
	chown nobody:nogroup ${D}/${I}
	chown nobody:nogroup ${D}/${I}/mprime

	dodoc license.txt readme.txt stress.txt whatsnew.txt undoc.txt

	exeinto /etc/init.d ; newexe ${FILESDIR}/gimps-init.d gimps
	insinto /etc/conf.d ; newins ${FILESDIR}/gimps-conf.d gimps
}

pkg_postinst () {

	einfo
	einfo "You can use \`/etc/init.d/gimps start\` to start a GIMPS client in the"
	einfo "background at boot. Have a look at /etc/conf.d/gimps and check some"
	einfo "configuration options."
	einfo ""
	einfo "If you don't want to use the init script to start gimps, remember"
	einfo "to cd into the directory where it should the data files first, eg.:"
	einfo "   cd /var/lib/gimps && ${I}/mprime"
	einfo
}

pkg_postrm () {

	einfo
	einfo "GIMPS data files were not removed."
	einfo "Remove them manually from /var/lib/gimps/."
	einfo
}
