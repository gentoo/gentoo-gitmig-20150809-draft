# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-6.1-r3.ebuild,v 1.3 2002/10/29 05:43:30 rphillips Exp $

inherit vim
DESCRIPTION="vim, gvim and kvim shared files"
KEYWORDS="x86 ppc sparc sparc64 alpha"
DEPEND="dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( sys-devel/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"

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

	# This should fix a sandbox violation. 
	addwrite "${SSH_TTY}"
	
	#
	# Build a nogui version, this will install as /usr/bin/vim
	#
	./configure \
		--prefix=/usr --mandir=/usr/share/man --host=$CHOST \
		--with-features=huge --with-cscope $myconf \
		--enable-gui=no \
		|| die "vim configure failed"
	# Parallel make does not work
	make || die "vim make failed"
	cd ${S}
	rm src/vim
}

src_install() {
	mkdir -p $D/usr/{bin,share/man/man1,share/vim}
	cd src
	make installruntime installhelplinks installmacros installtutor installtools install-languages install-icons DESTDIR=$D \
		BINDIR=/usr/bin MANDIR=/usr/share/man DATADIR=/usr/share
	# Docs
	dodoc README*
	cd $D/usr/share/doc/$PF
	ln -s ../../vim/*/doc $P

	#fix problems with vim not finding its data files.
	dodir /etc/env.d
	echo "VIMRUNTIME=/usr/share/vim/vim${vim_version/.}" \
		>${D}/etc/env.d/40vim
}

