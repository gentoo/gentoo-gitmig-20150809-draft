# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.2-r2.ebuild,v 1.3 2003/06/14 10:17:20 seemant Exp $

inherit libtool

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Motif"
HOMEPAGE="http://www.motifzone.org/"
SRC_URI="ftp://ftp.sgi.com/other/motifzone/2.2/src/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MOTIF"
KEYWORDS="~x86 ~ppc ~sparc"

PROVIDE="virtual/motif"

RDEPEND="virtual/x11"  
DEPEND=">=sys-apps/sed-4"

src_unpack() {

	local f list

	unpack ${A}
	cd ${S}
  
	#
	# Don't compile/install demo programs.
	#   They're meant to demonstrate programming techniques and features 
	#   of motif, but are of limited to no use for end users.  Further, 
	#   those progs that demonstrate Uil/Mrm functionality won't even work 
	#   because their data(.uid) files are installed in nonstandard places, 
	#   /usr/X11R6/share/Xm/<progname> (see `man MrmOpenHierarchy' for 
	#   locations Mrm expects them to be).  Most of the demos also don't 
	#   have compiled in fallback resources and will not work correctly 
	#   without their app-defaults files installed.
	#
	#   So there a basically 4 choices:
	#	a) add wrappers that set XAPPLRESDIR and UIDPATH,
	#	b) clutter two more system directories with demo related files,
	#	c) put sources, data, binaries AND wrappers in 
        #	   /usr/X11R6/share/Xm/ (move this to X11R6/lib/X11/Xm/demos ?),
	#	OR
	#	D) don't install them at all.
	#
	#
	ebegin "patching configure.in (no-demos patch)..."
	sed -i 's:^\(demos/.*\):dnl \1:g' configure.in
	eend $?

	ebegin "patching toplevel Makefile.am (no-demos patch)..."
	sed -i -e 's/\(\s*doc\) \\$/\1/' -e '/\s*demos$/d' Makefile.am
	eend $?

	#
	# fix include order (#6536):
	#   This replaces `include-order.diff'.  Had to change this patch so 
	#   it modifies Makefile.am instead of Makefile.in because rerunning 
	#   autotools below would undo any changes made to Makefile.in. 
	#   Added `clients/mwm/WmWsmLib/' to the list.
	#
	ebegin "fixing include order..."
	list="tools/wml/Makefile.am clients/mwm/WmWsmLib/Makefile.am"
	for f in ${list}; do
		einfo "    ...${f}"
		sed -i 's:\(^INCLUDES =\) \(\${X_CFLAGS}\) \(.*\):\1 \3 \2:' ${f}
	done
	eend $?
	unset f list

	#
	# move `system.mwmrc' from /usr/X11R6/lib/X11 to /etc/X11/mwm (FHS).
	#   Just symlinking `system.mwmrc' isn't enough here because mwm 
	#   also looks for localized verions in `$LANG/system.mwmrc'. 
	#   Instead, this patch changes the default location from 
	#   `/usr/X11R6/lib/X11/' to `/usr/X11R6/lib/X11/mwm/', which will 
	#   be symlinked to /etc/X11/mwm/ in src_install().
	#
	epatch "$FILESDIR/mwm-configdir.patch"
        
	#
	# missing srcfile in demos/programs/animate
	#
	#einfo "creating missing file demos/programs/animate/animate.c"
	#touch demos/programs/animate/animate.c

	#
	# Rebuild libtool (#15119, #20540, #21681)
	#
	elibtoolize

	#
	# Rebuild configure, Makefile.in
	#
	einfo "  ...aclocal..."
	aclocal || die "aclocal failed"
	einfo "  ...automake..."
	automake --foreign || die "automake failed"
	einfo "  ...autoconf..."
	autoconf || die "autoconf failed"
}


src_compile() {
	# get around some LANG problems in make (#15119)
	unset LANG

	./configure \
		--prefix=/usr/X11R6 \
		--sysconfdir=/etc/X11 \
		--with-x \
		--with-gnu-ld \
		--host=${CHOST} || die "configuration failed"

	make || die "make failed"
}


src_install() {

	local f list

	make \
		DESTDIR=${D} \
		VARDIR=${D}/var/X11/ install || die "make install failed"

	#
	# patch manpages to reflect actual location of configuration files
	#
	einfo "fixing manpages..."
	list="/usr/X11R6/man/man1/mwm.1 /usr/X11R6/man/man4/mwmrc.4"
	for f in $list; do
		einfo "    ...${D}/$f"
		dosed 's:/usr/X11R6/lib/X11/\(.*system\\&\.mwmrc\):/etc/X11/mwm/\1:g' "$f"
		dosed 's:/usr/X11R6/lib/X11/app-defaults:/etc/X11/app-defaults:g' "$f"
	done
	unset f list

	#
	# prepallman looks for manpages in /usr/X11R6/share/man while X11 uses 
	# /usr/X11R6/man, so we'll have to compress them ourselves...
	#
	einfo "gzipping manpages..."
	prepman "/usr/X11R6"

	#
	# move system.mwmrc & create symlink
	#
	einfo "moving system.mwmrc..."
	dodir "/etc/X11/mwm"
	mv "${D}/usr/X11R6/lib/X11/system.mwmrc" \
	   "${D}/etc/X11/mwm/system.mwmrc" || die "mv system.mwmrc"
	ln -s "../../../../etc/X11/mwm" \
	      "${D}/usr/X11R6/lib/X11/mwm" || die "ln -s confdir"


	#
	# app-defaults/Mwm isn't included anymore as of 2.2.2
	#
	einfo "creating mwm app-defaults file..."
	insinto /etc/X11/app-defaults
	newins ${FILESDIR}/Mwm.defaults Mwm

	einfo "installing docs..."
	dodoc COPYRIGHT.MOTIF LICENSE
	dodoc README RELEASE RELNOTES
	dodoc BUGREPORT OPENBUGS CLOSEDBUGS
}
