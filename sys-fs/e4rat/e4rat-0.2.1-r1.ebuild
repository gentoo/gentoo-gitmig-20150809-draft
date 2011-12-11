# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/e4rat/e4rat-0.2.1-r1.ebuild,v 1.1 2011/12/11 21:58:42 mgorny Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Toolset to accelerate the boot process and application startup"
HOMEPAGE="http://e4rat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-libs/boost-1.42
	sys-fs/e2fsprogs
	sys-process/audit"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-shared-build.patch
	"${FILESDIR}"/${PN}-libdir.patch
)
