# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/python-updater/python-updater-0.1.ebuild,v 1.4 2007/05/06 20:08:37 lucass Exp $

DESCRIPTION="Script used to remerge python packages when changing Python version."
HOMEPAGE="http://dev.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~kloeri/python-updater-0.1.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=sys-apps/portage-2.1.2 sys-apps/pkgcore sys-apps/paludis )"

src_install()
{
	cd "${WORKDIR}"
	newsbin ${P} ${PN}
}
