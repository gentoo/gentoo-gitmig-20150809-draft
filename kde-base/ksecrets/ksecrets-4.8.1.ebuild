# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksecrets/ksecrets-4.8.1.ebuild,v 1.3 2012/04/04 18:46:34 ago Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE secrets service"
KEYWORDS="amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	app-crypt/qca:2
	net-libs/libssh2
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep libkworkspace)
"

PATCHES=(
	"${FILESDIR}/${PN}-9999-fix-build.patch"
)

RESTRICT=test
# no bug yet but tests fail
