# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mcvs/mcvs-1.0.10.ebuild,v 1.3 2004/03/18 18:37:38 mkennedy Exp $

inherit common-lisp-common

DEB_PV=3

DESCRIPTION="Meta-CVS is a version control system built around CVS."
HOMEPAGE="http://users.footprints.net/~kaz/mcvs.html"
SRC_URI="http://users.footprints.net/~kaz/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/m/mcvs/mcvs_${PV}-${DEB_PV}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lisp/clisp-2.32
	dev-util/cvs
	app-text/rcs"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch mcvs_${PV}-${DEB_PV}.diff
}

src_install() {
	doman debian/mcvs.5
	dodoc ChangeLog LICENSE QUICK-GUIDE RELEASE-NOTES TODO UPGRADE-EXISTING
	do-debian-credits
	cd code && ./install.sh /usr ${D}
}
