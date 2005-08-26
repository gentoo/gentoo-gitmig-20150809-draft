# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gimps/gimps-24.13.ebuild,v 1.2 2005/08/26 17:59:15 spock Exp $

IUSE=""
DESCRIPTION="GIMPS - The Great Internet Mersenne Prime Search"
HOMEPAGE="http://mersenne.org/"
SRC_URI="ftp://mersenne.org/gimps/sprime${PV/./}.tar.gz"

# We have to use the statically linked version since the dynamically
# linked one requires gcc >= 3.4.4 (stdlibc++.so.6 dependency).

DEPEND=">=sys-apps/baselayout-1.8.0
	>=sys-libs/glibc-2.1"
SLOT="0"
LICENSE="as-is"
KEYWORDS="-* x86 ~amd64"

S="${WORKDIR}"
I="/opt/gimps"

src_install () {
	cd ${S}

	dodir ${I} /var/lib/gimps
	cp mprime ${D}/${I}
	chmod a-w ${D}/${I}/mprime
	chown root:0 ${D}/${I}
	chown root:0 ${D}/${I}/mprime

	dodoc license.txt readme.txt stress.txt whatsnew.txt undoc.txt

	exeinto /etc/init.d ; newexe ${FILESDIR}/gimps-init.d gimps
	insinto /etc/conf.d ; newins ${FILESDIR}/gimps-conf.d gimps
}

pkg_postinst () {
	echo
	einfo "You can use \`/etc/init.d/gimps start\` to start a GIMPS client in the"
	einfo "background at boot. Have a look at /etc/conf.d/gimps and check some"
	einfo "configuration options."
	einfo
	einfo "If you don't want to use the init script to start gimps, remember"
	einfo "to cd into the directory where the data files are to be stored first, eg.:"
	einfo "   cd /var/lib/gimps && ${I}/mprime"
	echo
}

pkg_postrm () {
	echo
	einfo "GIMPS data files were not removed."
	einfo "Remove them manually from /var/lib/gimps/"
	echo
}
