# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sr/sr-2.3.2.ebuild,v 1.8 2004/07/14 13:53:52 agriffis Exp $

inherit eutils

DESCRIPTION="SR (Synchronizing Resources) is a language for writing concurrent programs"
HOMEPAGE="http://www.cs.arizona.edu/sr"
SRC_URI="ftp://ftp.cs.arizona.edu/sr/sr.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/ssh"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
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

	doman man/*.[135]
}

pkg_postinst() {
	ranlib /usr/lib/sr/srlib.a
	strip /usr/lib/sr/srx
}
