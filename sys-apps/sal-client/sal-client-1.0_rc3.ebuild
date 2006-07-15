# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sal-client/sal-client-1.0_rc3.ebuild,v 1.12 2006/07/15 05:09:15 vapier Exp $

MY_P=${P/_/-}
DESCRIPTION="Client side programs for SAL, the Secure Auditing for Linux project."
HOMEPAGE="http://secureaudit.sourceforge.net/"
SRC_URI="mirror://sourceforge/secureaudit/${MY_P/rc3/RC3}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
# put a depend on hardened sources -- repoman doesn't like it, and we've got
# critical issues so blah

S=${WORKDIR}/sal-client

src_install() {
	dosbin daemon/auditd client/auditclient || die

	newinitd "${FILESDIR}"/sal-client-init auditd
	newconfd "${FILESDIR}"/auditd.confd auditd

	mv patches/README patches/README.patches
	mv patches/README.todo patches/README.todo.patches
	dodoc README README.todo patches/README.patches patches/README.todo.patches
}

pkg_postinst() {
	echo
	einfo "To create the necessary secure directory to hold your buffered logs,"
	einfo "please remember to configure using the following line:"
	echo
	einfo "emerge --config =${CATEGORY}/${PF}"
	echo
	ewarn "Please note that using the above method is NOT secure. You will need to explore"
	ewarn "either a crypto loopback filesystem, or other means of creating a secure jail"
	ewarn "for these temporary log files. We assume no responsibility for security breaches"
	ewarn "if you just use the above configure script."

}

pkg_config() {
	einfo "Creating default temporary log directory in ${ROOT}/var/lib/auditd"
	mkdir "${ROOT}"/var/lib/auditd
	chown root:0 "${ROOT}"/var/lib/auditd
	chmod 0600 "${ROOT}"/var/lib/auditd
}
