# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/kvim/kvim-6.1.141_rc2.ebuild,v 1.1 2002/09/13 09:17:58 hannes Exp $

inherit kde-base
need-kde 3

S="${WORKDIR}/${P//_}"
DESCRIPTION="KDE editor based on vim"
SRC_URI="http://www.freehackers.org/${PN}/dl/${P//_}.tar.bz2"
HOMEPAGE="http://www.freehackers.org/${PN}"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
newdepend "=app-editors/vim-core-6.1
    dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
    gpm?    ( >=sys-libs/gpm-1.19.3 )
    perl?   ( sys-devel/perl )
    python? ( dev-lang/python )
	ruby?   ( >=dev-lang/ruby-1.6.4 )"
				
src_compile() {
    use nls    && myconf="--enable-multibyte" || myconf="--disable-nls"
    use perl   && myconf="$myconf --enable-perlinterp"
    use python && myconf="$myconf --enable-pythoninterp"
	use ruby   && myconf="$myconf --enable-rubyinterp"
	use gpm    || myconf="$myconf --disable-gpm"
	myconf="$myconf --enable-gui=kde --with-features=huge --with-cscope \
		--with-vim-name=kvim"
	kde_src_compile myconf configure
    cd ${S}
    # emake does not work
    make || die 
}

src_install () {
	dodoc BUGS README.txt README_src.txt TODO kvim.lsm README.kvim README_lang.txt README_unix.txt
	dobin src/kvim
	ln -s kvim ${D}/usr/bin/kvimdiff
	#insinto /usr/share/vim
	#doins ${FILESDIR}/kvimrc
}
