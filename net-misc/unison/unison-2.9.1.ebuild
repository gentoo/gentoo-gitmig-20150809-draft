# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unison/unison-2.9.1.ebuild,v 1.7 2003/12/23 12:28:10 pyrania Exp $

IUSE="gtk"

DESCRIPTION="Two-way cross-platform file synchronizer"
HOMEPAGE="http://www.cis.upenn.edu/~bcpierce/unison/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND=">=dev-lang/ocaml-3.04
	gtk? ( >=dev-ml/lablgtk-1.2.3 )"
RDEPEND="gtk? ( >=x11-libs/gtk+-1.2.10 )"

SRC_URI="mirror://${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {

	local myconf

	if [ `use gtk` ]; then
		myconf="$myconf UISTYLE=gtk"
	else
		myconf="$myconf UISTYLE=text"
	fi

	make $myconf CFLAGS="" || die
}

src_install () {
	# install manually, since it's just too much
	# work to force the Makefile to do the right thing.
	dobin unison
	dodoc BUGS.txt CONTRIB COPYING INSTALL NEWS \
	      README ROADMAP.txt TODO.txt
}
