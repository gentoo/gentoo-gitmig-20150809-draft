# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/smart-live-rebuild/smart-live-rebuild-0.6.1.1.ebuild,v 1.1 2010/10/04 17:50:15 mgorny Exp $

PYTHON_DEPEND='*:2.6'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5'
inherit distutils python

DESCRIPTION="Check live packages for updates and emerge them as necessary"
HOMEPAGE="http://github.com/mgorny/smart-live-rebuild/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	distutils_src_install

	insinto /etc/portage
	newins smart-live-rebuild.conf{.example,} || die
	insinto /usr/share/portage/config/sets
	newins sets.conf.example ${PN}.conf || die
}
