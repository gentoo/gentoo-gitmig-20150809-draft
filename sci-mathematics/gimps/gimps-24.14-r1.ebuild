# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gimps/gimps-24.14-r1.ebuild,v 1.8 2008/07/16 23:13:13 mr_bones_ Exp $

inherit linux-info

IUSE=""
DESCRIPTION="GIMPS - The Great Internet Mersenne Prime Search"
HOMEPAGE="http://mersenne.org/"
SRC_URI="ftp://mersenne.org/gimps/sprime${PV/./}.tar.gz"

# We have to use the statically linked version since the dynamically
# linked one requires gcc >= 3.4.4 (stdlibc++.so.6 dependency).

DEPEND=">=sys-libs/glibc-2.1"
SLOT="0"
LICENSE="as-is"
KEYWORDS="-* amd64 x86"

S="${WORKDIR}"
I="/opt/gimps"

pkg_setup() {
	linux-info_pkg_setup

	if use amd64 && ! linux_chkconfig_present COMPAT_BINFMT_ELF ; then
		ewarn "This ebuild installs a statically linked 32-bit ELF binary."
		ewarn "You need to enable CONFIG_COMPAT_BINFMT_ELF in your kernel"
		ewarn "in order for it to be usable."
		die "missing CONFIG_COMPAT_BINFMT_ELF"
	fi
}

src_install() {
	dodir ${I} /var/lib/gimps
	cp mprime "${D}/${I}"
	chmod a-w "${D}/${I}/mprime"
	chown root:0 "${D}/${I}"
	chown root:0 "${D}/${I}/mprime"

	dodoc license.txt readme.txt stress.txt whatsnew.txt undoc.txt

	newinitd "${FILESDIR}/gimps-24.14-init.d" gimps
	newconfd "${FILESDIR}/gimps-24.14-conf.d" gimps
}

pkg_postinst() {
	echo
	einfo "You can use \`/etc/init.d/gimps start\` to start a GIMPS client in the"
	einfo "background at boot. Have a look at /etc/conf.d/gimps and check some"
	einfo "configuration options."
	einfo
	einfo "If you don't want to use the init script to start gimps, remember to"
	einfo "pass it an additional command line parameter specifying where the data"
	einfo "files are to be stored, e.g.:"
	einfo "   ${I}/mprime -w/var/lib/gimps"
	echo
}

pkg_postrm() {
	echo
	einfo "GIMPS data files were not removed."
	einfo "Remove them manually from /var/lib/gimps/"
	echo
}
