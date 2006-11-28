# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia/noia-1.0-r1.ebuild,v 1.7 2006/11/28 00:48:12 flameeyes Exp $

DESCRIPTION="The Noia icon theme"
SRC_URI="http://es.kde.org/downloads/noia-kde-icons-1.00.tgz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/noia_kde_100"

RESTRICT="binchecks strip"

src_install(){
	insinto /usr/share/icons/${PN}
	doins -r .
}
