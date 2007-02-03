# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-port/cl-port-1.0.1.2-r2.ebuild,v 1.8 2007/02/03 17:40:14 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=3

DESCRIPTION="Cross-implementation portability functions taken from the Common Lisp Object Code Collection"
HOMEPAGE="http://www.sourceforge.net/projects/clocc/ http://packages.debian.org/unstable/devel/cl-port.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/cl-port_${PV}-${DEB_PV}.diff.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=port

src_unpack() {
	unpack ${A}
	epatch cl-port_${PV}-${DEB_PV}.diff || die
	epatch ${FILESDIR}/${PV}-cmucl-graystream-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc port.html
}
