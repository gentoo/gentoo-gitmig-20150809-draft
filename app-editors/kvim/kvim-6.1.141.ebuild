# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kvim/kvim-6.1.141.ebuild,v 1.11 2003/07/02 16:16:33 agriffis Exp $

IUSE="python gpm nls ruby perl"

inherit kde-base
need-kde 3

S="${WORKDIR}/${P//_}"
DESCRIPTION="KDE editor based on vim"
SRC_URI="http://www.freenux.org/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.freehackers.org/${PN}"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc "
PATCHES="${FILESDIR}/${P}.patch"
newdepend "~app-editors/vim-core-6.1
	dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?    ( >=sys-libs/gpm-1.19.3 )
	perl?   ( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?   ( >=dev-lang/ruby-1.6.4 )"
				
src_compile() {
	use nls    && myconf="--enable-multibyte" || myconf="--disable-nls"
	use perl   && myconf="$myconf --enable-perlinterp"
	use python && myconf="$myconf --enable-pythoninterp"
	use ruby   && myconf="$myconf --enable-rubyinterp"
	use gpm    || myconf="$myconf --disable-gpm"
	myconf="$myconf --enable-gui=kde --with-features=huge --with-cscope \
		--with-vim-name=kvim --enable-kde-toolbar"
	kde_src_compile myconf configure
	cd ${S}
	# emake does not work
	make || die 
}

src_install() {
	dodoc BUGS README.txt README_src.txt TODO kvim.lsm README.kvim README_lang.txt README_unix.txt
	dobin src/kvim
	ln -s kvim ${D}/usr/bin/kvimdiff
}
