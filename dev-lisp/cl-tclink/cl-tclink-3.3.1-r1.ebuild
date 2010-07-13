# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-tclink/cl-tclink-3.3.1-r1.ebuild,v 1.11 2010/07/13 11:25:29 ssuominen Exp $

inherit common-lisp eutils multilib toolchain-funcs

DEB_PV=3

DESCRIPTION="Common Lisp TrustCommerce transaction authorization system."
HOMEPAGE="http://www.cliki.net/CL-TCLink http://www.mapcar.org/~mrd/cl-tclink/"
SRC_URI="http://www.mapcar.org/~mrd/debs/unstable/source/${PN}_${PV}.orig.tar.gz
	http://www.mapcar.org/~mrd/debs/unstable/source/${PN}_${PV}-${DEB_PV}.diff.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="dev-libs/openssl
	dev-lisp/cl-split-sequence
	dev-lisp/cl-uffi
	doc? ( virtual/latex-base )"

CLPACKAGE=tclink

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-{gentoo,Makefile,openssl-1}.patch
}

src_compile() {
	tc-export CC
	emake -C libtclink || die
#	use doc && make -C doc || die
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc Changelog doc/cl-tclink.txt
	exeinto /usr/$(get_libdir)/cl-tclink
	doexe libtclink/libtclink.so || die
	do-debian-credits
}
