# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.1-r3.ebuild,v 1.1 2002/10/27 22:52:29 rphillips Exp $

inherit vim
DESCRIPTION="graphical vim"

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
