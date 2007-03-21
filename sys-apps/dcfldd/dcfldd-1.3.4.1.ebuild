# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcfldd/dcfldd-1.3.4.1.ebuild,v 1.2 2007/03/21 17:25:15 armin76 Exp $

inherit versionator

My_PV=$(replace_version_separator 3 '-')

DESCRIPTION="enhanced dd with features for forensics and security"
HOMEPAGE="http://dcfldd.sourceforge.net/"
SRC_URI="mirror://sourceforge/dcfldd/${PN}-${My_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}-${My_PV}"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
