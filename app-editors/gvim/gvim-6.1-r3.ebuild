# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.1-r3.ebuild,v 1.9 2003/03/11 21:11:44 seemant Exp $

VIMPATCH="vimpatch-1-245.tar.bz2"
inherit vim

DESCRIPTION="graphical vim"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	sys-libs/libtermcap-compat
	app-editors/vim-core
	x11-base/xfree
	gpm?	( >=sys-libs/gpm-1.19.3 )
	gnome?	( gnome-base/gnome-libs )
	gtk?	( =x11-libs/gtk+-1.2* )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"
#	tcltk?	( dev-lang/tcl )"
# It appears that the tclinterp stuff in Vim is broken right now (at
# least on Linux... it works on BSD).  When you --enable-tclinterp
# flag, then the following command never returns:
#
#   VIMINIT='let OS = system("uname -s")' vim
#
# Please don't re-enable the tclinterp flag without verifying first
# that the above works.  Thanks.  (08 Sep 2001 agriffis)

src_compile() {
	local myconf
	use nls    && myconf="--enable-multibyte" || myconf="--disable-nls"
	use perl   && myconf="$myconf --enable-perlinterp"
	use python && myconf="$myconf --enable-pythoninterp"
	use ruby   && myconf="$myconf --enable-rubyinterp"
	
# tclinterp is BROKEN.  See note above DEPEND=
#	use tcltk  && myconf="$myconf --enable-tclinterp"

# Added back gpm for temporary will remove if necessary, I think that I have
# fixed most of gpm so it should be fine.
	use gpm    || myconf="$myconf --disable-gpm"

	if use gnome; then
		guiconf="--enable-gui=gnome --with-x"
	elif use gtk; then
		guiconf="--enable-gui=gtk --with-x"
	else
		guiconf="--enable-gui=athena --with-x"
	fi
	
	# This should fix a sandbox violation. 
	addwrite /dev/pty/*
	
	if [ -n "$guiconf" ]; then
		./configure \
			--prefix=/usr --mandir=/usr/share/man --host=$CHOST \
			--with-features=huge --enable-cscope $myconf $guiconf \
			--with-vim-name=gvim || die "gvim configure failed"
		# Parallel make does not work
		make || die "gvim make failed"
	fi
}

src_install() {
	dobin src/gvim
	ln -s gvim ${D}/usr/bin/gvimdiff
	# Default gvimrc
	insinto /usr/share/vim
	doins ${FILESDIR}/gvimrc
}
