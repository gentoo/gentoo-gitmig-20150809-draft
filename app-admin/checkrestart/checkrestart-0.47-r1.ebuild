# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/checkrestart/checkrestart-0.47-r1.ebuild,v 1.1 2011/02/12 17:48:33 jer Exp $

EAPI="3"

inherit eutils

DESCRIPTION="the sysadmin's rolling upgrade tool"
HOMEPAGE="http://arcdraco.net/checkrestart"
SRC_URI="http://arcdraco.net/~dragon/${P}-sep.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	sys-apps/lsb-release
	app-portage/portage-utils
	sys-process/lsof
	"

src_prepare() {
	epatch "${FILESDIR}"/${P}-list-comprehension-fix.patch
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
}
