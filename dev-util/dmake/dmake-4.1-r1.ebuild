# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dmake/dmake-4.1-r1.ebuild,v 1.15 2004/12/12 16:50:26 swegener Exp $

inherit eutils

DESCRIPTION="Improved make"
SRC_URI="http://plg.uwaterloo.ca/~ftp/dmake/${PN}-v${PV}-src-export.all-unknown-all.tar.gz"
HOMEPAGE="http://www.scri.fsu.edu/~dwyer/dmake.html"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="sys-apps/groff"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}.diff || die "epatch failed."
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
