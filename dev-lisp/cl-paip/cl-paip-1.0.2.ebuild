# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-paip/cl-paip-1.0.2.ebuild,v 1.6 2005/04/11 07:47:12 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp source code from Peter Norvig's book: Paradigms of Artificial Intelligence Programming"
HOMEPAGE="http://www.norvig.com/paip.html http://packages.debian.org/unstable/devel/cl-paip.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-paip/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-paip/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="Norvig"
KEYWORDS="x86 ~amd64"
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
