# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mcvs/mcvs-1.0.13.ebuild,v 1.7 2010/03/05 07:45:09 ulm Exp $

inherit common-lisp-common eutils

DEB_PV=2

DESCRIPTION="Meta-CVS is a version control system built around CVS."
HOMEPAGE="http://users.footprints.net/~kaz/mcvs.html"
SRC_URI="http://users.footprints.net/~kaz/${P}.tar.gz
	mirror://debian/pool/main/m/mcvs/mcvs_${PV}-${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-lisp/clisp-2.32
	dev-util/cvs
	dev-vcs/rcs"

src_unpack() {
	unpack ${A}
	epatch mcvs_${PV}-${DEB_PV}.diff
	epatch "${FILESDIR}"/${PV}-gentoo.patch
}

src_install() {
	doman debian/mcvs.1
	dodoc ChangeLog QUICK-GUIDE RELEASE-NOTES TODO UPGRADE-EXISTING
	do-debian-credits
	cd code && ./install.sh /usr "${D}"
}
