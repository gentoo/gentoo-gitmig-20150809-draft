# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.8.4.ebuild,v 1.5 2009/12/07 18:55:55 jer Exp $

inherit distutils

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	net-misc/whois
	virtual/mta"

src_install() {
	distutils_src_install

	diropts -m 0755 -o root -g root
	dodir /var/run/${PN}
	keepdir /var/run/${PN}

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
