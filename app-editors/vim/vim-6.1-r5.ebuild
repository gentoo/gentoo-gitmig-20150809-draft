# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r5.ebuild,v 1.1 2002/04/24 15:58:56 seemant Exp $

SRC_URI="ftp://ftp.vim.org/pub/vim/unix/${P}.tar.bz2
	ftp://ftp.us.vim.org/pub/vim/unix/${P}.tar.bz2"

DESCRIPTION="Vi IMproved!"
HOMEPAGE="http://www.vim.org/"
S=${WORKDIR}/${PN}${PV/./}
DEPEND="virtual/glibc 
		>=sys-libs/ncurses-5.2-r2
		dev-util/cscope
		>=sys-apps/portage-1.8.18
		gpm?	( >=sys-libs/gpm-1.19.3 )
		gnome?	( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		gtk?	( >=x11-libs/gtk+-1.2.10-r4 )
		X?		( x11-base/xfree )
		perl?	( sys-devel/perl )
		python? ( dev-lang/python )
		ruby?	( >=dev-lang/ruby-1.6.4 )"
#		tcltk?	( dev-lang/tcl )"
# It appears that the tclinterp stuff in Vim is broken right now (at
# least on Linux... it works on BSD).  When you --enable-tclinterp
# flag, then the following command never returns:
#
#   VIMINIT='let OS = system("uname -s")' vim
#
# Please don't re-enable the tclinterp flag without verifying first
# that the above works.  Thanks.  (08 Sep 2001 agriffis)

#src_unpack() {
#	unpack $A
#	# Fixup a script to use awk instead of nawk
#	cd $S/runtime/tools
#	mv mve.awk mve.awk.old
#	( read l; echo "#!/usr/bin/awk -f"; cat ) <mve.awk.old >mve.awk
#	# Apply any patches available for this version
#	local patches=`echo $FILESDIR/$PV.[0-9][0-9][0-9]`
#	case "$patches" in
#		*\]) 
#			;; # globbing didn't work; no patches available
#		*)
#			cd $S
#			for a in $patches; do
#				patch -p0 < $a
#			done
#			;;
#	esac
#	# Also apply the ebuild syntax patch, until this is in Vim proper
#	cd $S/runtime
#	patch -f -p0 < ${FILESDIR}/ebuild.patch
#}

src_compile() {

	local myconf
	use nls    || myconf="--disable-nls"
	use gpm    || myconf="$myconf --disable-gpm"
	use perl   && myconf="$myconf --enable-perlinterp"
	use python && myconf="$myconf --enable-pythoninterp"
	use ruby   && myconf="$myconf --enable-rubyinterp"
# tclinterp is BROKEN.  See note above DEPEND=
#	use tcltk  && myconf="$myconf --enable-tclinterp"

	#
	# First, build a gui version, this will install as /usr/bin/gvim
	#
	if use gnome; then
		guiconf="--enable-gui=gnome --with-x"
	elif use gtk; then
		guiconf="--enable-gui=gtk --with-x"
	elif use X; then
		guiconf="--enable-gui=athena --with-x"
	else
		# No gui version will be built
		guiconf=""
	fi
	if [ -n "$guiconf" ]; then
		./configure \
			--prefix=/usr --mandir=/usr/share/man --host=$CHOST \
			--with-features=huge --enable-cscope $myconf $guiconf \
			|| die "gvim configure failed"
		# Parallel make does not work
		make || die "gvim make failed"
		mv src/vim src/gvim
	fi

	#
	# Second, build a nogui version, this will install as /usr/bin/vim
	#
	./configure \
		--prefix=/usr --mandir=/usr/share/man --host=$CHOST \
		--with-features=huge --with-cscope $myconf \
		--enable-gui=no --without-x \
		|| die "vim configure failed"
	# Parallel make does not work
	make || die "vim make failed"
}

src_install() {
	# Install the nogui version
	mkdir -p $D/usr/{bin,share/man/man1,share/vim}
	make install STRIP=true DESTDIR=$D \
		BINDIR=/usr/bin MANDIR=/usr/share/man DATADIR=/usr/share
	# Install the gui version, if it was built
	if [ -f src/gvim ]; then
		install -m755 src/gvim $D/usr/bin/gvim
		ln -s gvim $D/usr/bin/gvimdiff
	fi
	# Docs
	dodoc README*
	cd $D/usr/share/doc/$PF
	ln -s ../../vim/*/doc $P
	# Default vimrc and gvimrc (who cares if gvim wasn't built)
	insinto /usr/share/vim
	doins ${FILESDIR}/vimrc ${FILESDIR}/gvimrc

	#fix problems with vim not finding its data files.
	dodir /etc/env.d
	echo "VIMRUNTIME=/usr/share/vim/vim${vim_version/.}" \
		>${D}/etc/env.d/40vim
}
