# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aima/cl-aima-1.0.2-r1.ebuild,v 1.1 2004/02/12 09:13:12 mkennedy Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="Common Lisp source code from Peter Norvig's Artificial Intelligence: A Modern Approach"
HOMEPAGE="http://aima.cs.berkeley.edu/
	http://www.norvig.com/
	http://packages.debian.org/unstable/devel/cl-aima.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-aima/cl-aima_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-aima/cl-aima_${PV}-${DEB_PV}.diff.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=aima

S=${WORKDIR}/cl-aima-${PV}

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	insinto /usr/share/common-lisp/source/aima/
	doins debian/aima.asd aima.lisp
	for module in agents language learning logic search uncertainty utilities; do
		find ${module} -type f -name \*.lisp -print | while read lisp; do \
			local dir=${D}/usr/share/common-lisp/source/aima/$(dirname ${lisp})
			mkdir -p ${dir} &>/dev/null
			cp ${lisp} ${dir}
		done
		mv ${module}/README.html README-${module}.html && dohtml README-${module}.html
	done
	common-lisp-system-symlink
	dohtml doc/*
	do-debian-credits
}
