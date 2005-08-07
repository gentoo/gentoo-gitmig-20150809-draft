# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.1-r1.ebuild,v 1.20 2005/08/07 12:51:11 hansmi Exp $

inherit eutils

DESCRIPTION="Improved make"
SRC_URI="http://public.activestate.com/gsar/${P}pl1-src.tar.gz"
HOMEPAGE="http://tools.openoffice.org/tools/dmake.html"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND="sys-apps/groff"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}.diff
}

src_compile() {
	sh unix/linux/gnu/make.sh || die "sh unix/linux/gnu/make.sh failed"
}

src_install () {
	dobin dmake || die "dobin failed"
	newman man/dmake.tf dmake.1 || die "newman failed"

	insinto /usr/share/dmake/startup
	doins -r startup/{{startup,config}.mk,unix} || die "doins failed"
}
