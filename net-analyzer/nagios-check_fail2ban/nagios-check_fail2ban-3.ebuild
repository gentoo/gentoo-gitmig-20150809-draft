# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-check_fail2ban/nagios-check_fail2ban-3.ebuild,v 1.1 2010/05/30 06:31:01 hollow Exp $

EAPI="2"

inherit multilib autotools

DESCRIPTION="A nagios plugin for checking the fail2ban daemon"
HOMEPAGE="http://bb.xnull.de/projects/check_fail2ban/"
SRC_URI="http://bb.xnull.de/projects/check_fail2ban/dist/check_fail2ban-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-analyzer/nagios-plugins-1.4.13-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/check_fail2ban-${PV}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
