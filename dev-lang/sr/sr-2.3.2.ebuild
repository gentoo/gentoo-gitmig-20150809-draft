# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sr/sr-2.3.2.ebuild,v 1.3 2003/02/13 10:29:45 vapier Exp $

IUSE=""

DESCRIPTION="SR (Synchronizing Resources) is a language for writing concurrent programs."
HOMEPAGE="http://www.cs.arizona.edu/sr"

SRC_URI="ftp://ftp.cs.arizona.edu/sr/sr.tar.Z"

S=${WORKDIR}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="net-misc/openssh"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/sr-2.3.2.patch
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	# commands
	dobin sr/sr
	dobin srl/srl
	dobin srm/srm
	dobin srprof/srprof
	dobin srtex/srtex
	dobin srlatex/srlatex
	dobin srgrind/srgrind
	dobin preproc/*2sr

	# library components
	insinto /usr/lib/sr
	doins sr.h
	doins srmulti.h
	doins rts/srlib.a
	doins library/*.o
	doins library/*.spec
	doins library/*.impl
	doins srmap
	doins rts/srx
	doins srlatex/srlatex.sty
	doins preproc/*2sr.h
	doins sr-mode.el

	# man pages
	insinto /usr
	doman man/sr.1
	doman man/srl.1
	doman man/srm.1
	doman man/srprof.1
	doman man/srtex.1
	doman man/srlatex.1
	doman man/srgrind.1
	doman man/ccr2sr.1
	doman man/m2sr.1
	doman man/csp2sr.1
	doman man/sranimator.3
	doman man/srgetopt.3
	doman man/srwin.3
	doman man/srmap.5
	doman man/srtrace.5
}

pkg_postinst() {
	ranlib /usr/lib/sr/srlib.a
	strip /usr/lib/sr/srx
}
