# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-paip/cl-paip-1.0.2.ebuild,v 1.9 2007/02/03 17:38:30 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp source code from Peter Norvig's book: Paradigms of Artificial Intelligence Programming"
HOMEPAGE="http://www.norvig.com/paip.html http://packages.debian.org/unstable/devel/cl-paip.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="Norvig"
KEYWORDS="~amd64 ~ppc ~sparc x86"
SLOT="0"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=paip

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff || die
	epatch ${FILESDIR}/${PV}-package-lock-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp debian/paip.asd
	common-lisp-system-symlink
	dohtml *.html
	do-debian-credits
}
