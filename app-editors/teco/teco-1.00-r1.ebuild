# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/teco/teco-1.00-r1.ebuild,v 1.2 2003/06/18 08:28:02 taviso Exp $

DESCRIPTION="Classic TECO editor, Predecessor to EMACS."
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/editors/tty/"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/editors/tty/teco.tar.gz
	doc? ( http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco/doc/tecolore.txt )
	doc? ( http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco/doc/tech.txt )
	doc? ( http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco/doc/teco.doc )
	doc? ( http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco/doc/tecoprog.doc )"
LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha x86"
IUSE="doc"
DEPEND="virtual/glibc
	sys-libs/libtermcap-compat
	>=sys-apps/sed-4"
RDEPEND="virtual/glibc
	sys-libs/libtermcap-compat"

inherit ccc
	
S=${WORKDIR}

src_unpack() {
	unpack teco.tar.gz || die "sorry, couldnt unpack teco."
}

src_compile() {
	sed -i 's/CFLAGS = -O//' Makefile 
	is-ccc && replace-cc-hardcode
	
	emake || die "compilation failed"
	
	echo
	size te
	echo
}

src_install() {
	dobin te
	dodoc sample.tecorc sample.tecorc2 READ.ME MANIFEST 
	use doc && dodoc ${DISTDIR}/{tecolore.txt,tech.txt,teco.doc,tecoprog.doc}
	doman te.1
}

pkg_postinst() {
	einfo "The TECO binary is called te."
	einfo "Sample configurations and documentation is available in /usr/share/doc/"
}
