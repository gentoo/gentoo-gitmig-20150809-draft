# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.8.1.ebuild,v 1.1 2007/08/31 15:06:17 falco Exp $

inherit distutils

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	virtual/mta"

src_install() {
	distutils_src_install

	newconfd files/gentoo-confd fail2ban
	newinitd files/gentoo-initd fail2ban
	dodoc CHANGELOG README TODO || die "dodoc failed"
	doman man/*.1 || die "doman failed"
}

pkg_postinst() {
	if has_version '<net-analyzer/fail2ban-0.7' ; then
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

pkg_setup() {
	if ! built_with_use dev-lang/python readline ; then
		echo
		eerror "dev-lang/python is missing readline support. Please add"
		eerror "'readline' to your USE flags, and re-emerge dev-lang/python."
		die "dev-lang/python needs readline support"
	fi
}
