# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nsca/nagios-nsca-2.7.2-r101.ebuild,v 1.1 2012/08/18 00:17:19 flameeyes Exp $

EAPI=4

inherit multilib

DESCRIPTION="Nagios NSCA  - Nagios Service Check Acceptor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nsca-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="tcpd"

DEPEND=">=dev-libs/libmcrypt-2.5.1-r4
	tcpd? ( sys-apps/tcp-wrappers )"

RDEPEND="${DEPEND}
	sys-apps/openrc"

S="${WORKDIR}/nsca-${PV}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_configure() {
	use tcpd || export ac_cv_lib_wrap_main=no

	econf
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--with-nsca-user=nagios \
		--with-nsca-grp=nagios
}

src_install() {
	dodoc LEGAL Changelog README SECURITY

	insinto /etc/nagios
	doins "${S}"/sample-config/nsca.cfg
	doins "${S}"/sample-config/send_nsca.cfg

	dobin src/send_nsca

	exeinto /usr/libexec
	doexe src/nsca

	newinitd "${FILESDIR}"/nsca.init nsca
}

pkg_postinst() {
	elog "If you are using the nsca daemon, remember to edit"
	elog "the config file /etc/nagios/nsca.cfg"
}
