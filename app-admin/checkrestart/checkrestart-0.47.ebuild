# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/checkrestart/checkrestart-0.47.ebuild,v 1.1 2008/11/20 21:30:02 jer Exp $

DESCRIPTION="the sysadmin's rolling upgrade tool"
HOMEPAGE="http://arcdraco.net/checkrestart"
SRC_URI="http://arcdraco.net/~dragon/${P}-sep.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~x86"
IUSE=""

RDEPEND="
	sys-apps/lsb-release
	app-portage/portage-utils
	sys-process/lsof
	"

src_install() {
	dosbin ${PN} || die "dosbin failed"
}
