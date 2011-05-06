# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.8.4-r3.ebuild,v 1.3 2011/05/06 02:30:22 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="net-misc/whois
	virtual/mta
	net-firewall/iptables"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-hashlib.patch \
		"${FILESDIR}"/${P}-sshd-breakin.patch \
		"${FILESDIR}"/gentoo-initd_create_run_dir.patch \
		"${FILESDIR}"/${P}-cve2009-5023.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	newconfd files/gentoo-confd fail2ban
	newinitd files/gentoo-initd fail2ban
	dodoc ChangeLog README TODO || die "dodoc failed"
	doman man/*.1 || die "doman failed"

	# Use INSTALL_MASK  if you do not want to touch /etc/logrotate.d.
	# See http://thread.gmane.org/gmane.linux.gentoo.devel/35675
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}-logrotate ${PN} || die
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.7"
	previous_less_than_0_7=$?
}

pkg_postinst() {
	distutils_pkg_postinst

	if [[ $previous_less_than_0_7 = 0 ]] ; then
		elog
		elog "Configuration files are now in /etc/fail2ban/"
		elog "You probably have to manually update your configuration"
		elog "files before restarting Fail2ban!"
		elog
		elog "Fail2ban is not installed under /usr/lib anymore. The"
		elog "new location is under /usr/share."
		elog
		elog "You are upgrading from version 0.6.x, please see:"
		elog "http://www.fail2ban.org/wiki/index.php/HOWTO_Upgrade_from_0.6_to_0.8"
	fi
}
