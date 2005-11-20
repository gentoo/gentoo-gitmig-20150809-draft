# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ucblogo/ucblogo-5.5.ebuild,v 1.2 2005/11/20 06:42:47 vapier Exp $

inherit eutils

DESCRIPTION="a reflective, functional programming language"
HOMEPAGE="http://www.cs.berkeley.edu/~bh/logo.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs X"

DEPEND="X? ( virtual/x11 )
	emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-fhs.patch
	epatch "${FILESDIR}"/${P}-dont-require-tetex.patch
	use emacs || echo 'all install:' > emacs/makefile
}

src_compile() {
	econf $(use_with X x) || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}
