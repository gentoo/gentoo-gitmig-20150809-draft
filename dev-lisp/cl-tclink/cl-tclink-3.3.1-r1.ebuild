# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-tclink/cl-tclink-3.3.1-r1.ebuild,v 1.6 2005/02/08 07:02:25 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=3

DESCRIPTION="Common Lisp TrustCommerce transaction authorization system."
HOMEPAGE="http://www.cliki.net/CL-TCLink http://www.mapcar.org/~mrd/cl-tclink/"
SRC_URI="http://www.mapcar.org/~mrd/debs/unstable/source/${PN}_${PV}.orig.tar.gz
	http://www.mapcar.org/~mrd/debs/unstable/source/${PN}_${PV}-${DEB_PV}.diff.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="dev-lisp/common-lisp-controller
	dev-libs/openssl
	dev-lisp/cl-split-sequence
	dev-lisp/cl-uffi
	doc? ( virtual/tetex )
	virtual/commonlisp"

CLPACKAGE=tclink

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff || die
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_compile() {
	make -C libtclink CFLAGS="-fPIC ${CFLAGS}" || die
#	use doc && make -C doc || die
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc ChangeLog LLGPL LICENSE
	dodoc doc/cl-tclink.txt
	exeinto /usr/lib/cl-tclink
	doexe libtclink/libtclink.so
	do-debian-credits
}
