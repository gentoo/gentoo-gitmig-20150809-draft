# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.7.2.ebuild,v 1.1 2006/09/19 09:14:58 strerror Exp $

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	net-firewall/iptables"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# mail-report.conf does not exist anymore
	sed -i -e "s/'config\/action.d\/mail-report.conf',//" setup.py
}

src_install() {
	# Use python setup
	python setup.py install --root="${D}" || die

	# Init.d script
	newinitd files/gentoo-initd fail2ban

	# Doc
	#doman man/*.[0-9]
	dodoc CHANGELOG README TODO
}

pkg_postinst() {
	einfo
	einfo "Configuration files are now in /etc/fail2ban"
	einfo
}

