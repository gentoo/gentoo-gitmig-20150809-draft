# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r19.ebuild,v 1.9 2003/03/14 15:59:13 tuxus Exp $

IUSE="nls perl python ruby tcltk gpm X"

VIMPATCH="300"
EXCLUDE_PATCH="093 100 119 121 126 138 152 164 258 \
304 314 322 334 335 340 346 352 353 354 355 356 374"

use nls || EXCLUDE_PATCH="${EXCLUDE_PATCH} 295 301"

inherit vim

DESCRIPTION="Vi IMproved!"
KEYWORDS="x86 ppc sparc alpha hppa arm mips"
DEPEND="app-editors/vim-core
	sys-libs/libtermcap-compat
	dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"
#	tcltk?	( dev-lang/tcl )"

PROVIDE="virtual/editor"

src_compile() {
	local myconf
	myconf="--with-features=big --enable-multibyte"
	use nls    && myconf="$myconf --enable-multibyte"
	use nls    || myconf="$myconf --disable-nls"
	use perl   && myconf="$myconf --enable-perlinterp"
	use python && myconf="$myconf --enable-pythoninterp"
	use ruby   && myconf="$myconf --enable-rubyinterp"
	
# tclinterp is BROKEN.  See note above DEPEND=
#	use tcltk  && myconf="$myconf --enable-tclinterp"

# Added back gpm for temporary will remove if necessary, I think that I have
# fixed most of gpm so it should be fine.
	use gpm    || myconf="$myconf --disable-gpm"
	
	# the console vim will change the caption of a terminal in X.
	# the configure script should autodetect X being installed, so
	# we'll specifically turn it off if X is not in the USE vars.
	# -rphillips
	use X      && myconf="$myconf --with-x" || myconf="$myconf --without-x"

	# This should fix a sandbox violation. 
 	for file in /dev/pty/s*
 	do
 		addwrite $file
 	done

	#
	# Build a nogui version, this will install as /usr/bin/vim
	#
	econf \
		--enable-gui=no \
		--with-features=huge \
		--enable-cscope ${myconf} \
		|| die "vim configure failed"

	# move config files to /etc/vim/
	echo "#define SYS_VIMRC_FILE \"/etc/vim/vimrc\"" \
		>>${WORKDIR}/vim61/src/feature.h
	echo "#define SYS_GVIMRC_FILE \"/etc/vim/gvimrc\"" \
		>>${WORKDIR}/vim61/src/feature.h

	# Parallel make does not work
	make || die "vim make failed"
}

src_install() {
	dobin src/vim
	ln -s vim ${D}/usr/bin/vimdiff
	ln -s vim ${D}/usr/bin/rvim
	ln -s vim  ${D}/usr/bin/ex
	ln -s vim  ${D}/usr/bin/view
	ln -s vim  ${D}/usr/bin/rview
	
	# Default vimrc
	insinto /etc/vim/
	doins ${WORKDIR}/gentoo/vimrc
}

pkg_postinst() {
	einfo
	einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
	einfo
}
