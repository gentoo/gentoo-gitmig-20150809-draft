# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unison/unison-2.12.2.ebuild,v 1.1 2005/03/14 20:21:12 mattam Exp $

inherit eutils

IUSE="gtk gtk2 doc"

DESCRIPTION="Two-way cross-platform file synchronizer"
HOMEPAGE="http://www.cis.upenn.edu/~bcpierce/unison/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=dev-lang/ocaml-3.04
	gtk? ( gtk2? ( >=dev-ml/lablgtk-2.2 ) !gtk2? ( =dev-ml/lablgtk-1.2* ) )
	doc? ( net-www/lynx >=dev-tex/hevea-1.07 virtual/tetex virtual/ghostscript )"

RDEPEND="gtk? ( gtk2? ( >=dev-ml/lablgtk-2.2 ) !gtk2? ( =dev-ml/lablgtk-1.2* )
|| ( net-misc/x11-ssh-askpass net-misc/gtk2-ssh-askpass ) )"

#SRC_URI="http://www.cis.upenn.edu/~bcpierce/unison/download/beta-test/${P}/${P}.tar.gz"
SRC_URI="http://www.cis.upenn.edu/~bcpierce/unison/download/resources/developers-only/${P}.tar.gz"

pkg_setup() {
	ewarn "This is a beta release, use at your very own risk"
}

src_unpack() {
	unpack ${P}.tar.gz

	# Fix for coreutils change of tail syntax
	cd ${S}
	sed -i -e 's/tail -1/tail -n 1/' src/Makefile.OCaml
}

src_compile() {
	local myconf

	if use gtk; then
		if use gtk2; then
			myconf="$myconf UISTYLE=gtk2"
		else
			myconf="$myconf UISTYLE=gtk"
		fi
	else
		myconf="$myconf UISTYLE=text"
	fi

	make $myconf CFLAGS="" || die "error making unsion"
	if use doc; then
		make -C doc || die "error making doc"
	fi
}

src_install () {
	# install manually, since it's just too much
	# work to force the Makefile to do the right thing.
	cd src
	dobin unison || die
	dodoc BUGS.txt CONTRIB COPYING INSTALL NEWS \
	      README ROADMAP.txt TODO.txt || die
	cd ..
	if use doc; then
		cd doc
		dodoc unison-manual.ps || die
		doinfo unison-manual.info* || die
		dohtml *.html || die
		insinto /usr/share/doc/${PF}
		doins unison-manual.pdf || die
		cd ../icons
		dohtml Unison.gif
		cd ..
	fi
}
