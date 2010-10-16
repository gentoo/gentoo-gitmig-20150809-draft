# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gimps/gimps-26.3.ebuild,v 1.1 2010/10/16 21:24:46 spock Exp $

IUSE=""
DESCRIPTION="GIMPS - The Great Internet Mersenne Prime Search"
HOMEPAGE="http://mersenne.org/"
SRC_URI="amd64? ( ftp://mersenne.org/gimps/mprime${PV/./}-linux64.tar.gz )
	x86? ( ftp://mersenne.org/gimps/mprime${PV/./}.tar.gz )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"

# Since there are no statically linked binaries for this version of mprime,
# and no static binaries for amd64 in general, we use the dynamically linked
# ones and try to cover the .so deps with the packages listed in RDEPEND.
DEPEND="x86? ( dev-util/bsdiff )"
RDEPEND="net-misc/curl"

S="${WORKDIR}"
I="/opt/gimps"

QA_EXECSTACK="opt/gimps/mprime"

src_install() {
	dodir ${I} /var/lib/gimps
	cp mprime "${D}/${I}"
	chmod 0555 "${D}/${I}/mprime"
	chown root:0 "${D}/${I}"
	chown root:0 "${D}/${I}/mprime"

	dodoc license.txt readme.txt stress.txt whatsnew.txt undoc.txt

	newinitd "${FILESDIR}/gimps-25.7-init.d" gimps
	newconfd "${FILESDIR}/gimps-25.6-conf.d" gimps
}

pkg_postinst() {
	echo
	einfo "You can use \`/etc/init.d/gimps start\` to start a GIMPS client in the"
	einfo "background at boot. Have a look at /etc/conf.d/gimps and check some"
	einfo "configuration options."
	einfo
	einfo "If you are a new user, you will need to configure GIMPS before"
	einfo "starting the initscript.  To do so, run:"
	einfo "   ${I}/mprime -w/var/lib/gimps"
	einfo "followed by:"
	einfo "   chown nobody:nobody /var/lib/gimps/*"
	einfo
	einfo "If you have an existing GIMPS account, follow the instructions at:"
	einfo "   http://mersenne.org/freesoft/#upgradeusers"
	einfo "and do not blindy restart gimps."
	echo
}

pkg_postrm() {
	echo
	einfo "GIMPS data files were not removed."
	einfo "Remove them manually from /var/lib/gimps/"
	echo
}
