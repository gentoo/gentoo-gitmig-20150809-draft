# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/python-updater/python-updater-9999.ebuild,v 1.3 2011/01/01 00:16:47 arfrever Exp $

inherit subversion

DESCRIPTION="Script used to remerge python packages when changing Python version."
HOMEPAGE="http://www.gentoo.org/proj/en/Python"
SRC_URI=""
ESVN_REPO_URI="https://overlays.gentoo.org/svn/proj/python/projects/${PN}/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/help2man"
RDEPEND="!<dev-lang/python-2.3.6-r2
	dev-lang/python
	|| ( >=sys-apps/portage-2.1.2 sys-apps/pkgcore sys-apps/paludis )"

src_compile() {
	emake ${PN}.1 || die "Generation of man page failed"
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
	doman ${PN}.1 || die "doman failed"
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
