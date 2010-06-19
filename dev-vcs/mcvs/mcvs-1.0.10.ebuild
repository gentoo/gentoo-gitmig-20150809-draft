# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mcvs/mcvs-1.0.10.ebuild,v 1.2 2010/06/19 00:53:28 abcd Exp $

inherit common-lisp-common eutils

DEB_PV=3

DESCRIPTION="Meta-CVS is a version control system built around CVS."
HOMEPAGE="http://users.footprints.net/~kaz/mcvs.html"
SRC_URI="http://users.footprints.net/~kaz/${P}.tar.gz
	mirror://debian/pool/main/m/mcvs/mcvs_${PV}-${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lisp/clisp-2.32
	dev-vcs/cvs
	dev-vcs/rcs"

src_unpack() {
	unpack ${A}
	epatch mcvs_${PV}-${DEB_PV}.diff
}

src_install() {
	doman debian/mcvs.5
	dodoc ChangeLog QUICK-GUIDE RELEASE-NOTES TODO UPGRADE-EXISTING
	do-debian-credits
	cd code && ./install.sh /usr "${D}"
}
