# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/byobu/byobu-2.16.ebuild,v 1.1 2009/06/26 03:34:04 weaver Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/byobu"
SRC_URI="https://launchpad.net/~byobu/+archive/ppa/+files/byobu_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper"
RDEPEND="app-misc/screen
	dev-libs/newt"

S="${WORKDIR}/byobu_${PV}.orig"

#src_prepare() {
#	epatch "${WORKDIR}"/*.diff
#}

src_install() {
	ln -s "${D}" debian/byobu
	ln -s "${D}" debian/byobu-extras
	emake --makefile=debian/rules install || die
	doman *.1
	dodoc doc/*
}

pkg_postinst() {
	elog 'To access the functionality of this package, please run the command "byobu"'
	elog 'in place of "screen".'
}
