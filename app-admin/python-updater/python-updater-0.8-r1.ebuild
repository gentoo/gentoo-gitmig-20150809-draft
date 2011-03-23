# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/python-updater/python-updater-0.8-r1.ebuild,v 1.1 2011/03/23 16:06:42 jer Exp $

inherit eutils

DESCRIPTION="Script used to remerge python packages when changing Python version."
HOMEPAGE="http://www.gentoo.org/proj/en/Python"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="!<dev-lang/python-2.3.6-r2
	dev-lang/python
	|| ( >=sys-apps/portage-2.1.2 sys-apps/paludis )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-splitdebug.patch
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
	doman ${PN}.1 || die "doman failed"
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
