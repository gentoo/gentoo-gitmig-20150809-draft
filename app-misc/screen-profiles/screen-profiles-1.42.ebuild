# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen-profiles/screen-profiles-1.42.ebuild,v 1.1 2009/04/07 22:37:12 weaver Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/screen-profiles"
SRC_URI="mirror://ubuntu/pool/main/s/screen-profiles/screen-profiles_${PV}.orig.tar.gz
	mirror://ubuntu/pool/main/s/screen-profiles/screen-profiles_${PV}-0ubuntu1.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper"
RDEPEND="app-misc/screen
	dev-libs/newt"

src_prepare() {
	epatch "${WORKDIR}"/*.diff
}

src_install() {
	ln -s "${D}" debian/screen-profiles
	ln -s "${D}" debian/screen-profiles-extras
	emake --makefile=debian/rules install || die
	mv "${D}/usr/bin/screen" "${D}/usr/bin/myscreen" || die
	dosym screen /usr/bin/screen.real || die
	doman *.1
	dodoc doc/*
}

pkg_postinst() {
	elog "To access the functionality of this package, please run the command `myscreen'"
	elog "in place of `screen'."
}
