# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.21.ebuild,v 1.3 2008/12/21 16:48:26 nixnut Exp $

DESCRIPTION="stub build"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_postinst() {
	ewarn "This is a stub ebuild for upgrading to 0.21."
	ewarn "Unmerge it since it's integrated into MythTV"
}
