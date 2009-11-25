# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/byobu/byobu-2.38.ebuild,v 1.1 2009/11/25 19:32:53 weaver Exp $

EAPI="2"

inherit eutils

MY_UBUNTU_PLVL=3
MY_UBUNTU_P="${PV}-0ubuntu${MY_UBUNTU_PLVL}"

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/byobu"
SRC_URI="https://launchpad.net/ubuntu/karmic/+source/byobu/${MY_UBUNTU_P}/+files/byobu_${PV}.orig.tar.gz
	https://launchpad.net/ubuntu/karmic/+source/byobu/${MY_UBUNTU_P}/+files/byobu_${MY_UBUNTU_P}.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper"
RDEPEND="app-misc/screen
	dev-libs/newt
	>=dev-lang/python-2.5"

S="${WORKDIR}/byobu_${PV}.orig"

src_prepare() {
	epatch "${WORKDIR}"/*.diff
}

src_install() {
	ln -s "${D}" debian/byobu
	ln -s "${D}" debian/byobu-extras
	emake --makefile=debian/rules install || die
	chmod +x "${D}/usr/bin/byobu-janitor"
	rm -rf "${D}/debian"
	doman *.1 || die
	dodoc doc/*
}

pkg_postinst() {
	elog 'To access the functionality of this package, please run the command "byobu"'
	elog 'in place of "screen".'
}
