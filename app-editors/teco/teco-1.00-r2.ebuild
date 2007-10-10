# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/teco/teco-1.00-r2.ebuild,v 1.9 2007/10/10 07:22:43 opfer Exp $

inherit ccc

DESCRIPTION="Classic TECO editor, Predecessor to EMACS"
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/editors/tty/ http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/editors/tty/teco.tar.gz
	doc? ( mirror://gentoo/tecolore.txt.gz
		mirror://gentoo/tech.txt.gz
		mirror://gentoo/teco.doc.gz
		mirror://gentoo/tecoprog.doc.gz )"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha ~ppc x86"
IUSE="doc"

RDEPEND="virtual/libc"
DEPEND="${DEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	# Remove hardcoded compiler and CFLAGS
	sed -i \
		-e 's/CFLAGS = -O//' \
		-e 's:-ltermcap:-lncurses:' \
		Makefile
	replace-cc-hardcode
}

src_compile() {
	emake || die "compilation failed"
}

src_install() {
	dobin te || die
	dodoc sample.tecorc sample.tecorc2 READ.ME MANIFEST
	use doc && dodoc tecolore.txt tech.txt teco.doc tecoprog.doc
	doman te.1
}

pkg_postinst() {
	elog "The TECO binary is called te."
	elog "Sample configurations and documentation is available in /usr/share/doc/"
}
