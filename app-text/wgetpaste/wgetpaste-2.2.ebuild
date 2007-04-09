# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wgetpaste/wgetpaste-2.2.ebuild,v 1.1 2007/04/09 11:37:25 armin76 Exp $

DESCRIPTION="Command-line interface to various pastebins"
HOMEPAGE="http://wgetpaste.zlin.dk/"
SRC_URI="${HOMEPAGE}/${PF}.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/sed
		net-misc/wget"

S="${WORKDIR}"

src_compile() {
	sed -i "s|@VERSION@|${PV}|" "${P}" || die "Failed to insert version."
}

src_install() {
	newbin "${P}" "${PN}"
}
