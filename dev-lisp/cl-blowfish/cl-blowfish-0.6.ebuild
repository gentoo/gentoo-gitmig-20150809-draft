# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-blowfish/cl-blowfish-0.6.ebuild,v 1.8 2007/02/03 17:33:37 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp implementation of the Blowfish encryption algorithm."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-blowfish.html http://members.optusnet.com.au/apicard/"
SRC_URI="mirror://gentoo/cl-blowfish_${PV}.orig.tar.gz
	mirror://gentoo/cl-blowfish_${PV}-${DEB_PV}.diff.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=blowfish


src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
}
