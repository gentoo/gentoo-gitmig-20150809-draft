# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-split-sequence/cl-split-sequence-20011114.1.ebuild,v 1.2 2003/10/17 16:40:35 mkennedy Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="Functions to partition a Common Lisp sequence into multiple result sequences"
HOMEPAGE="http://www.cliki.net/SPLIT-SEQUENCE
	http://packages.debian.org/unstable/devel/cl-split-sequence.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-split-sequence/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-split-sequence/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${P}

CLPACKAGE=split-sequence

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install split-sequence.asd split-sequence.lisp
	common-lisp-system-symlink
	do-debian-credits
}


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
