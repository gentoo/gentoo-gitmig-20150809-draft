# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.1-r13.ebuild,v 1.1 2002/09/25 03:34:53 jnelson Exp $

# Please name the ebuild as follows.  If this is followed, there
# should be no need to modify this ebuild when the Vim version is
# updated.  (Yes it's overkill, but it was fun!)
#
#   vim-6.0, when 6.0 is finally released
#   vim-6.0_pre9, where 9 = (i), for vim-6.0i
#   vim-6.0_pre47, where 47 = 26(a) + 21(u), for vim-6.0au
#   vim-6.0_pre72, where 72 = 52(b) + 20(t), for vim-6.0bt
#
# Quick reference:
#   a=1   e=5   i=9   m=13  q=17  u=21  y=25
#   b=2   f=6   j=10  n=14  r=18  v=22  z=26
#   c=3   g=7   k=11  o=15  s=19  w=23 aa=27
#   d=4   h=8   l=12  p=16  t=20  x=24 ab=28 (etc.)
#
# (08 Sep 2001 agriffis)

set -e

# Calculate the version based on the name of the ebuild
vim_version="${PV%_pre*}"
vim_pre="${PV##*_pre}"
VIMPATCH="vimpatch-1-146.tar.bz2"

if [ "$vim_version" = "$vim_pre" ]; then
	# Final releases prior to 6.0 include a dash and decimal point in
	# the directory name
	if [ "${vim_version%%.*}" -lt 6 ]; then
		S="$WORKDIR/vim-$vim_version"
	else
		S="$WORKDIR/vim${vim_version//.}"
	fi
	vim_letters=
	A="vim-$vim_version.tar.bz2"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unix/$A
			 ftp://ftp.us.vim.org/pub/vim/unix/$A
			 http://www.ibiblio.org/gentoo/distfiles/${VIMPATCH}"
elif [ "$vim_pre" -lt 27 ]; then
	# Handle (prerelease) versions with one trailing letter
	vim_letters=`echo $vim_pre | awk '{printf "%c", $0+96}'`
	S="$WORKDIR/vim${vim_version//.}$vim_letters"
	A="vim-$vim_version$vim_letters.tar.bz2"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/$A
			 ftp://ftp.us.vim.org/pub/vim/unreleased/unix/$A
			 http://www.ibiblio.org/gentoo/distfiles/${VIMPATCH}"

elif [ "$vim_pre" -lt 703 ]; then
	# Handle (prerelease) versions with two trailing letters
	vim_letters=`echo $vim_pre | awk '{printf "%c%c", $0/26+96, $0%26+96}'`
	S="$WORKDIR/vim${vim_version//.}$vim_letters"
	A="vim-$vim_version$vim_letters.tar.bz2"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/$A
			 ftp://ftp.us.vim.org/pub/vim/unreleased/unix/$A
			 http://www.ibiblio.org/gentoo/distfiles/${VIMPATCH}"
else
	die "Eek!  I don't know how to interpret the version!"
fi

DESCRIPTION="Vi IMproved!"
HOMEPAGE="http://www.vim.org/"

SLOT="0"
LICENSE="vim"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="=app-editors/vim-core-6.1
	dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	gpm?	( >=sys-libs/gpm-1.19.3 )
	perl?	( sys-devel/perl )
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


src_unpack() {
	unpack ${A}
	# Fixup a script to use awk instead of nawk
	cd ${S}/runtime/tools
	mv mve.awk mve.awk.old
	( read l; echo "#!/usr/bin/awk -f"; cat ) <mve.awk.old >mve.awk
	# Another set of patch's borrowed from src rpm to fix syntax error's etc.
	cd ${WORKDIR}
	tar xvjf  ${FILESDIR}/vimpatch.tar.bz2 
	cd $S
	patch -p1 < ${WORKDIR}/vim-4.2-speed_t.patch || die
	patch -p1 < ${WORKDIR}/vim-5.1-vimnotvi.patch || die
	patch -p1 < ${WORKDIR}/vim-5.6a-paths.patch || die
	patch -p1 < ${WORKDIR}/vim-6.0-fixkeys.patch || die
	patch -p1 < ${WORKDIR}/vim-6.0-gcc31.patch || die
	patch -p1 < ${WORKDIR}/vim-6.0-specsyntax.patch || die
	patch -p1 < ${WORKDIR}/vim-6.0r-crv.patch || die
			
	cd ${WORKDIR}
	tar xvjf ${DISTDIR}/${VIMPATCH}
	cd ${S}

	if test -f ${WORKDIR}/6.1.080; then rm -f ${WORKDIR}/6.1.080; fi
	if test -f ${WORKDIR}/6.1.084; then rm -f ${WORKDIR}/6.1.084; fi
	# Apply any patches available for this version
	local patches=`echo ${WORKDIR}/${PV}.[0-9][0-9][0-9]`
	case "$patches" in
		*\]) 
			;; # globbing didn't work; no patches available
		*)
			cd $S
			for a in $patches; do
				echo -n "Applying patch $a..."
				patch -p0 < $a > /dev/null || die
				echo "OK"
			done
			;;
	esac
	patch -p0 < ${FILESDIR}/6.1_patches.80.84.diff || die
}

src_compile() {
	local myconf
	myconf="--without-x"
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
}

src_install() {
	dobin src/vim
	ln -s vim ${D}/usr/bin/vimdiff
	# Default vimrc
	insinto /usr/share/vim
	doins ${FILESDIR}/vimrc
}

pkg_postinst() {
	einfo ""
	einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
}
