# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-cclan/cl-cclan-1.86.ebuild,v 1.4 2008/03/27 16:16:51 armin76 Exp $

inherit common-lisp eutils

DEB_PV=2

DESCRIPTION="Comprehensive Common Lisp Archive Network"
HOMEPAGE="http://cclan.sourceforge.net http://www.cliki.net/cclan http://packages.debian.org/unstable/devel/cl-cclan"
SRC_URI="mirror://gentoo/cl-asdf_${PV}-${DEB_PV}.diff.gz
	mirror://gentoo/cl-asdf_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-asdf
	virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=cclan

S=${WORKDIR}/cl-asdf-${PV}

src_unpack() {
	unpack ${A}
	epatch cl-asdf_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install cclan*.lisp cclan.asd
	common-lisp-system-symlink
	do-debian-credits
}
