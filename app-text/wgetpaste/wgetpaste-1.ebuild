# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wgetpaste/wgetpaste-1.ebuild,v 1.1 2007/02/12 21:02:10 eroyf Exp $

DESCRIPTION="Command-line interface to rafb.net/paste using only wget"
HOMEPAGE="http://zlin.dk/"
SRC_URI="${HOMEPAGE}/${PF}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/sed
		 net-misc/wget"

src_install() {
	newbin "${DISTDIR}/${PF}" "${PN}"
}
