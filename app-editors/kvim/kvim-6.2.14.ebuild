# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kvim/kvim-6.2.14.ebuild,v 1.1 2003/08/13 14:48:01 agriffis Exp $

IUSE="python gpm nls ruby perl"

inherit kde-base
need-kde 3

S="${WORKDIR}/${P//_}"
DESCRIPTION="KDE editor based on vim"
SRC_URI="http://freenux.org/${PN}/${P//_}.tar.bz2"
HOMEPAGE="http://www.freehackers.org/${PN}"
LICENSE="GPL-2"
KEYWORDS="~alpha x86 sparc"
newdepend ">=app-editors/vim-core-6.2
	ncurses? ( >=sys-libs/ncurses-5.2-r2 ) : ( sys-libs/libtermcap-compat )
	cscope? ( dev-util/cscope )
	gpm?    ( >=sys-libs/gpm-1.19.3 )
	perl?   ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?   ( dev-lang/ruby )"

src_compile() {
	myconf="--with-features=huge \
		--enable-multibyte \
		--enable-gui=kde \
		--with-vim-name=kvim \
		--enable-kde-toolbar"
	myconf="${myconf} `use_enable cscope`"
	myconf="${myconf} `use_enable gpm`"
	myconf="${myconf} `use_enable perl perlinterp`"
	myconf="${myconf} `use_enable python pythoninterp`"
	myconf="${myconf} `use_enable ruby rubyinterp`"
	myconf="${myconf} `use_enable nls`"

	# Note: If USE=gpm, then ncurses will still be required
	use ncurses \
		&& myconf="${myconf} --with-tlib=ncurses" \
		|| myconf="${myconf} --with-tlib=termcap"

    # Let kde.eclass handle the configuration
	kde_src_compile myconf configure
	make || die  # emake does not work
}

src_install() {
	dodoc README.txt README_src.txt README_lang.txt README_unix.txt
	dobin src/kvim
	ln -s kvim ${D}/usr/bin/kvimdiff
}
