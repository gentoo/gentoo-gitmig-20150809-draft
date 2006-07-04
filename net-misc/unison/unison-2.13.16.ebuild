# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unison/unison-2.13.16.ebuild,v 1.3 2006/07/04 10:52:13 mattam Exp $

inherit eutils

IUSE="gtk doc static debug threads"

DESCRIPTION="Two-way cross-platform file synchronizer"
HOMEPAGE="http://www.cis.upenn.edu/~bcpierce/unison/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"

DEPEND=">=dev-lang/ocaml-3.04
	gtk? ( >=dev-ml/lablgtk-2.2 )"

RDEPEND="gtk? ( >=dev-ml/lablgtk-2.2
|| ( net-misc/x11-ssh-askpass net-misc/gtk2-ssh-askpass ) )"

PDEPEND="gtk? ( || ( media-font/font-schumacher-misc <virtual/x11-7 ) )"

SRC_URI="http://www.cis.upenn.edu/~bcpierce/unison/download/releases/${P}/${P}.tar.gz
doc? ( http://www.cis.upenn.edu/~bcpierce/unison/download/releases/${P}/${P}-manual.pdf
	http://www.cis.upenn.edu/~bcpierce/unison/download/releases/${P}/${P}-manual.html )"

src_unpack() {
	unpack ${P}.tar.gz

	# Fix for coreutils change of tail syntax
	cd ${S}
	sed -i -e 's/tail -1/tail -n 1/' Makefile.OCaml
}

src_compile() {
	local myconf

	if use threads; then
		myconf="$myconf THREADS=true"
	fi

	if use static; then
		myconf="$myconf STATIC=true"
	fi

	if use debug; then
		myconf="$myconf DEBUGGING=true"
	fi

	if use gtk; then
		myconf="$myconf UISTYLE=gtk2"
	else
		myconf="$myconf UISTYLE=text"
	fi

	make $myconf CFLAGS="" || die "error making unsion"
}

src_install () {
	# install manually, since it's just too much
	# work to force the Makefile to do the right thing.
	dobin unison || die
	dodoc BUGS.txt CONTRIB COPYING INSTALL NEWS \
	      README ROADMAP.txt TODO.txt || die

	if use doc; then
		dohtml ${DISTDIR}/${P}-manual.html || die
		dodoc ${DISTDIR}/${P}-manual.pdf || die
	fi
}
