# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kvim/kvim-6.2.14.ebuild,v 1.15 2004/10/16 19:27:44 vapier Exp $

inherit kde eutils

DESCRIPTION="KDE editor based on vim"
HOMEPAGE="http://www.freehackers.org/${PN}"
SRC_URI="http://freenux.org/${PN}/${P//_}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="alpha x86 sparc ppc ~amd64"
IUSE="python gpm nls ruby perl cscope ncurses"

DEPEND=">=app-editors/vim-core-6.2
	>=sys-libs/ncurses-5.2-r2
	cscope? ( dev-util/cscope )
	gpm?    ( >=sys-libs/gpm-1.19.3 )
	perl?   ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?   ( dev-lang/ruby )"
need-kde 3

S="${WORKDIR}/${P//_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/kvim-6.2.14-gcc2.patch
	# Resolve conflicting symbol "e_number" between vim and perl 5.8.2
	epatch ${FILESDIR}/kvim-6.2.14-perl582.patch
}

src_compile() {
	myconf="--with-features=huge \
		--enable-multibyte \
		--enable-gui=kde \
		--with-vim-name=kvim \
		--enable-kde-toolbar \
		--with-tlib=ncurses"
	myconf="${myconf} `use_enable cscope`"
	myconf="${myconf} `use_enable gpm`"
	myconf="${myconf} `use_enable perl perlinterp`"
	myconf="${myconf} `use_enable python pythoninterp`"
	myconf="${myconf} `use_enable ruby rubyinterp`"
	myconf="${myconf} `use_enable nls`"

	# Let kde.eclass handle the configuration
	kde_src_compile myconf configure
	make || die  # emake does not work
}

src_install() {
	dodoc README.txt README_src.txt README_lang.txt README_unix.txt
	dobin src/kvim
	ln -s kvim ${D}/usr/bin/kvimdiff
}
