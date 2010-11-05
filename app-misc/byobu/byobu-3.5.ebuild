# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/byobu/byobu-3.5.ebuild,v 1.1 2010/11/05 23:36:38 weaver Exp $

EAPI="2"

PYTHON_DEPEND="2"

inherit eutils python

MY_UBUNTU_RELEASE=maverick
MY_UBUNTU_PLVL=1
MY_UBUNTU_P="${PV}-0ubuntu${MY_UBUNTU_PLVL}"

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/byobu"
SRC_URI="https://launchpad.net/ubuntu/${MY_UBUNTU_RELEASE}/+source/byobu/${MY_UBUNTU_P}/+files/byobu_${PV}.orig.tar.gz
	https://launchpad.net/ubuntu/${MY_UBUNTU_RELEASE}/+source/byobu/${MY_UBUNTU_P}/+files/byobu_${MY_UBUNTU_P}.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper"
RDEPEND="app-misc/screen
	dev-libs/newt"

src_prepare() {
	EPATCH_OPTS="-p1" epatch "${WORKDIR}"/*.diff
	python_convert_shebangs -r 2 .
}

src_install() {
	einstall || die
}

pkg_postinst() {
	elog 'To access the functionality of this package, please run the command "byobu"'
	elog 'in place of "screen".'
}
