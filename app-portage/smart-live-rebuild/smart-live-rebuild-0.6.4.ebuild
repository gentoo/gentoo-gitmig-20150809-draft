# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/smart-live-rebuild/smart-live-rebuild-0.6.4.ebuild,v 1.1 2010/10/23 08:10:08 mgorny Exp $

EAPI="3"
PYTHON_DEPEND='*:2.6'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5'
inherit distutils

DESCRIPTION="Check live packages for updates and emerge them as necessary"
HOMEPAGE="http://github.com/mgorny/smart-live-rebuild/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PYTHON_MODNAME=SmartLiveRebuild

src_install() {
	distutils_src_install

	insinto /etc/portage
	newins smart-live-rebuild.conf{.example,} || die
	insinto /usr/share/portage/config/sets
	newins sets.conf.example ${PN}.conf || die
}
