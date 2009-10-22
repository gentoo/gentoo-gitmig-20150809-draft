# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/khdapsmonitor/khdapsmonitor-0.1-r1.ebuild,v 1.2 2009/10/22 19:48:35 bangert Exp $

EAPI="2"
ARTS_REQUIRED="never"
inherit kde

DESCRIPTION="KDE monitor for the Hard Drive Active Protection System"
HOMEPAGE="http://roy.marples.name/projects/khdaps/wiki"
SRC_URI="http://roy.marples.name/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5

PATCHES=(
	"${FILESDIR}/khdapsmonitor-0.1-support-kernels-after-2.6.27.patch"
	"${FILESDIR}/khdapsmonitor-0.1-fix-desktop-file.patch"
)
