# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.7.6-r1.ebuild,v 1.1 2007/03/03 22:08:16 falco Exp $

inherit distutils

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}.init.d.patch"
}

src_install() {
	distutils_src_install

	newconfd "${FILESDIR}"/fail2ban.conf.d fail2ban || die "newconfd failed"
	newinitd files/gentoo-initd fail2ban || die "newinitd failed"
	dodoc CHANGELOG README TODO
	doman man/*.1
}

pkg_postinst() {
	einfo
	einfo "Configuration files are now in /etc/fail2ban"
	einfo
}

