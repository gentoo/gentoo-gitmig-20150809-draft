# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aima/cl-aima-1.0.4.ebuild,v 1.5 2007/02/03 17:31:46 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp source code from Peter Norvig's Artificial Intelligence: A Modern Approach"
HOMEPAGE="http://aima.cs.berkeley.edu/ http://www.norvig.com/ http://packages.debian.org/unstable/devel/cl-aima.html"
SRC_URI="mirror://gentoo/cl-aima_${PV}.orig.tar.gz
	mirror://gentoo/cl-aima_${PV}-${DEB_PV}.diff.gz"
LICENSE="Norvig"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/cl-aima-${PV}

CLPACKAGE=aima

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
	epatch ${FILESDIR}/${PV}-defsystem-and-package-lock-gentoo.patch
}

src_install() {
	insinto /usr/share/common-lisp/source/aima/
	doins aima.asd aima.lisp
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
	find ${D} -type f -exec chmod 644 '{}' \;
}
