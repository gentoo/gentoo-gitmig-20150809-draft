# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-split-sequence/cl-split-sequence-20011114.1-r1.ebuild,v 1.6 2005/03/18 07:32:29 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Functions to partition a Common Lisp sequence into multiple result sequences"
HOMEPAGE="http://www.cliki.net/SPLIT-SEQUENCE http://packages.debian.org/unstable/devel/cl-split-sequence.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-split-sequence/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-split-sequence/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

CLPACKAGE=split-sequence

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff || die
}

src_install() {
	common-lisp-install split-sequence.asd split-sequence.lisp
	common-lisp-system-symlink
	do-debian-credits
}
