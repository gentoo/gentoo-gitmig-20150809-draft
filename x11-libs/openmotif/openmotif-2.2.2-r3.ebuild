# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.2-r3.ebuild,v 1.9 2003/12/16 23:13:15 agriffis Exp $

inherit libtool motif

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Motif"
HOMEPAGE="http://www.motifzone.org/"
SRC_URI="ftp://ftp.sgi.com/other/motifzone/2.2/src/${MY_P}.tar.gz"

SLOT="2.2"
LICENSE="MOTIF"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~amd64 ia64"

PROVIDE="virtual/motif"

RDEPEND="virtual/x11"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
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
	#   be symlinked to /etc/X11/mwm/.
	#
	epatch "$FILESDIR/mwm-configdir.patch"

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

	make || die "make failed, if you have lesstif installed removed it, compile openmotif and recompile lesstif"
}


src_install() {
	make \
		DESTDIR=${D} \
		VARDIR=${D}/var/X11/ install || die "make install failed"


	einfo "Fixing includes"
	dodir /usr/include/Mrm/2.2/Mrm
	dodir /usr/include/Xm/2.2/Xm
	dodir /usr/include/uil/2.2/uil

	mv ${D}/usr/X11R6/include/Mrm/*.h ${D}/usr/include/Mrm/2.2/Mrm
	mv ${D}/usr/X11R6/include/Xm/*.h ${D}/usr/include/Xm/2.2/Xm
	mv ${D}/usr/X11R6/include/uil/*.h ${D}/usr/include/uil/2.2/uil


	einfo "Fixing binaries"
	dodir /usr/bin
	for file in `ls ${D}/usr/X11R6/bin`
	do
		mv ${D}/usr/X11R6/bin/${file} ${D}/usr/bin/${file}-2.2
	done


	einfo "Fixing libraries"
	dodir /usr/lib/motif/2.2
	mv ${D}/usr/X11R6/lib/lib* ${D}/usr/lib/motif/2.2

	for lib in libMrm.so.3 libMrm.so.3.0.1 \
		libXm.so.3 libXm.so.3.0.1 \
		libUil.so.3 libUil.so.3.0.1
	do
		dosym "/usr/lib/motif/2.2/${lib}"\
			"/usr/lib/${lib}"
	done


	einfo "Fixing man pages"
	dodir /usr/share/man/man1
	dodir /usr/share/man/man3
	dodir /usr/share/man/man4
	dodir /usr/share/man/man5

	for file in `ls ${D}/usr/X11R6/man/man1`
	do
		file=${file/.1/}
		mv ${D}/usr/X11R6/man/man1/${file}.1 ${D}/usr/share/man/man1/${file}-22.1
	done
	for file in `ls ${D}/usr/X11R6/man/man3`
	do
		file=${file/.3/}
		mv ${D}/usr/X11R6/man/man3/${file}.3 ${D}/usr/share/man/man3/${file}-22.3
	done
	for file in `ls ${D}/usr/X11R6/man/man4`
	do
		file=${file/.4/}
		mv ${D}/usr/X11R6/man/man4/${file}.4 ${D}/usr/share/man/man4/${file}-22.4
	done
	for file in `ls ${D}/usr/X11R6/man/man5`
	do
		file=${file/.5/}
		mv ${D}/usr/X11R6/man/man5/${file}.5 ${D}/usr/share/man/man5/${file}-22.5
	done


	einfo "Cleaning up"
	rm -fR ${D}/usr/X11R6/


	einfo "Fixing docs"
	dodoc COPYRIGHT.MOTIF LICENSE
	dodoc README RELEASE RELNOTES
	dodoc BUGREPORT OPENBUGS CLOSEDBUGS
}
