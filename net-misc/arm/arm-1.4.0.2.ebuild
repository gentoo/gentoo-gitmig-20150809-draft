# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arm/arm-1.4.0.2.ebuild,v 1.1 2010/12/06 12:11:32 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="ncurses"

inherit versionator python distutils
MY_P=${PN}-$(replace_version_separator 3 -)

DESCRIPTION="A ncurses-based status monitor for Tor relays"
HOMEPAGE="http://www.atagar.com/arm/"
SRC_URI="http://www.atagar.com/arm/resources/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-misc/tor-0.2.1.27"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

pkg_postinst() {
	elog "Some graphing data issues have been noted in testing"
	elog "when run as root. It is not reccomended to run arm as"
	elog "root until those issues have been isolated and fixed."
	elog
	elog "Trouble with graphs under app-misc/screen? Try:"
	elog 'TERM="rxvt-unicode" arm'
}
