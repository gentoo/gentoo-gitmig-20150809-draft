# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sr/sr-2.3.3.ebuild,v 1.5 2009/12/23 10:17:00 dev-zero Exp $

inherit eutils versionator

MY_PV=$(delete_all_version_separators)
DESCRIPTION="SR (Synchronizing Resources) is a language for writing concurrent programs"
HOMEPAGE="http://www.cs.arizona.edu/sr"
SRC_URI="ftp://ftp.cs.arizona.edu/sr/${PN}${MY_PV}.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/ssh
	!app-misc/srm"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/${P}.patch
	sed -i -e "s:SRSRC = /usr/local/src/sr:SRSRC = ${S}:" \
		-e "s:/usr/local:/usr:" -e "s:/usr/X11/lib:/usr/lib:" \
		-e "s:CCPATH = /bin/cc:CCPATH = /usr/bin/gcc:" \
		-e "s:RSHPATH = /usr/ucb/rsh:RSHPATH = /usr/bin/ssh:" \
		-e "s:VFPATH = /usr/lib/vfontedpr:VFPATH = :" Configuration \
		|| die "seding Configuration failed"
}

src_compile() {
	emake || die "make failed"
}

src_test() {
	rm -f vsuite/examples/other/mbrot/Script
	rm -f vsuite/examples/other/remote/Script
	rm -f vsuite/quick/vm/Script
	srv/srv || die "At least one test failed"
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

	ranlib rts/srlib.a

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
