# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gentooalt-m4/gentooalt-m4-20051010.ebuild,v 1.1 2005/10/13 10:08:19 flameeyes Exp $

DESCRIPTION="Macro files for Gentoo/ALT"
HOMEPAGE="http://gentoo-alt.gentoo.org/"
SRC_URI="http://digilander.libero.it/dgp85/gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/m4s"

src_compile() {
	einfo "Do Nothing"
}

src_install() {
	insinto /usr/share/aclocal
	doins ${S}/*.m4
}
