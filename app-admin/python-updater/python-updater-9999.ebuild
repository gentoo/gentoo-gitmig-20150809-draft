# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/python-updater/python-updater-9999.ebuild,v 1.1 2008/06/20 17:56:02 hawking Exp $

inherit subversion

DESCRIPTION="Script used to remerge python packages when changing Python version."
HOMEPAGE="http://www.gentoo.org/proj/en/Python"
SRC_URI=""
ESVN_REPO_URI="http://overlays.gentoo.org/svn/proj/python/projects/${PN}/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/help2man"
RDEPEND="!<dev-lang/python-2.3.6-r2
	|| ( >=sys-apps/portage-2.1.2 sys-apps/pkgcore sys-apps/paludis )"

src_compile() {
	emake ${PN}.1 || die "couldn't generate manpage"
}

src_install()
{
	doman ${PN}.1
	dosbin ${PN}
	dodoc AUTHORS ChangeLog
}
