# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.4-r2.ebuild,v 1.4 2004/07/28 18:47:25 avenj Exp $

inherit eutils flag-o-matic 64-bit gnuconfig

DESCRIPTION="Linux console display library"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
SRC_URI="mirror://gnu/ncurses/${P}.tar.gz"

LICENSE="MIT"
SLOT="5"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="build bootstrap debug uclibc"

DEPEND="virtual/libc"
# This doesn't fix the problem. bootstrap builds ncurses again with
# normal USE flags while bootstrap is unset, which apparently causes
# things to break -- avenj  2 Apr 04
#	!bootstrap? ( gpm? ( sys-libs/gpm ) )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-xterm.patch
	# Bug #42336.
	epatch ${FILESDIR}/${P}-share-sed.patch
}

src_compile() {
	local myconf=

	filter-flags -fno-exceptions

	use debug || myconf="${myconf} --without-debug"

	# Shared objects are compiled properly with -fPIC, but
	# standard libs also require this.
	64-bit && append-flags -fPIC
	filter-ldflags -pie

	# Detect mips systems
	use mips && gnuconfig_update

	# From version 5.3, ncurses also build c++ bindings, and as
	# we do not have a c++ compiler during bootstrap, disable
	# building it.  We will rebuild ncurses after gcc's second
	# build in bootstrap.sh.
	# <azarah@gentoo.org> (23 Oct 2002)
	( use build || use bootstrap || use uclibc ) \
		&& myconf="${myconf} --without-cxx --without-cxx-binding --without-ada"

	# see note about DEPEND above -- avenj@gentoo.org  2 Apr 04
#	use gpm && myconf="${myconf} --with-gpm"

	# We need the basic terminfo files in /etc, bug #37026.  We will
	# add '--with-terminfo-dirs' and then populate /etc/terminfo in
	# src_install() ...
	econf \
		--libdir=/lib \
		--with-terminfo-dirs="/etc/terminfo:/usr/share/terminfo" \
		--disable-termcap \
		--with-shared \
		--with-rcs-ids \
		--without-ada \
		--enable-symlinks \
		${myconf} \
		|| die "configure failed"

	# A little hack to fix parallel builds ... they break when
	# generating sources so if we generate the sources first (in
	# non-parallel), we can then build the rest of the package
	# in parallel.  This is not really a perf hit since the source
	# generation is quite small.  -vapier
	emake -j1 sources || die "make sources failed"
	emake || die "make failed"
}

src_install() {
	local x=

	make DESTDIR=${D} install || die "make install failed"

	# Move static and extraneous ncurses libraries out of /lib
	cd ${D}/lib
	dodir /usr/lib
	mv libform* libmenu* libpanel* ${D}/usr/lib
	mv *.a ${D}/usr/lib
	# bug #4411
	gen_usr_ldscript libncurses.so || die "gen_usr_ldscript failed"

	# We need the basic terminfo files in /etc, bug #37026
	einfo "Installing basic terminfo files in /etc..."
	# added some for uclibc
	#for x in dumb linux rxvt screen sun vt{52,100,102,220} xterm
	for x in ansi console dumb linux rxvt screen sun vt{52,100,102,200,220} xterm xterm-color xterm-xfree86
	do
		local termfile="$(find "${D}/usr/share/terminfo/" -name "${x}" 2>/dev/null)"
		local basedir="$(basename $(dirname "${termfile}"))"

		if [ -n "${termfile}" ]
		then
			dodir /etc/terminfo/${basedir}
			mv ${termfile} ${D}/etc/terminfo/${basedir}/
			dosym ../../../../etc/terminfo/${basedir}/${x} \
				/usr/share/terminfo/${basedir}/${x}
		fi
	done

	# Build fails to create this ...
	dosym ../share/terminfo /usr/lib/terminfo

	dodir /etc/env.d
	echo "CONFIG_PROTECT_MASK=\"/etc/terminfo\"" > ${D}/etc/env.d/50ncurses

	if use build
	then
		cd ${D}
		rm -rf usr/share/man
		cd usr/share/terminfo
		cp -a l/linux n/nxterm v/vt100 ${T}
		rm -rf *
		mkdir l x v
		cp -a ${T}/linux l
		cp -a ${T}/nxterm x/xterm
		cp -a ${T}/vt100 v
		# bash compilation requires static libncurses libraries, so
		# this breaks the "build a new build image" system.  We now
		# need to remove libncurses.a from the build image manually.
		# cd ${D}/usr/lib; rm *.a
		# remove extraneous ncurses libraries
		cd ${D}/usr/lib; rm -f lib{form,menu,panel}*
		cd ${D}/usr/include; rm -f {eti,form,menu,panel}.h
	else
		if ( use bootstrap || use uclibc ) ; then
			cd ${D}/usr/lib; rm -f lib{form,menu,panel,ncurses++}*
			cd ${D}/usr/include; rm -f {eti,form,menu,panel}.h cursesapp.h curses?.h cursslk.h etip.h
		fi
		# Install xterm-debian terminfo entry to satisfy bug #18486
		LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${D}/usr/lib:${D}/lib \
			TERMINFO=${D}/usr/share/terminfo \
			${D}/usr/bin/tic ${FILESDIR}/xterm-debian.ti

		if use uclibc ; then
			cp ${D}/usr/share/terminfo/x/xterm-debian ${D}/etc/terminfo/x/
			rm -rf ${D}/usr/share/terminfo/*
		fi

		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
		dodoc doc/*.doc
		dohtml -r doc/html/
	fi
}

pkg_preinst() {
	if [ ! -f "${ROOT}/etc/env.d/50ncurses" ]
	then
		mkdir -p "${ROOT}/etc/env.d"
		echo "CONFIG_PROTECT_MASK=\"/etc/terminfo\"" > \
			${ROOT}/etc/env.d/50ncurses
	fi
}

pkg_postinst() {
	# Old ncurses may still be around from old build tbz2's.
	rm -f /lib/libncurses.so.5.[23]
	rm -f /usr/lib/lib{form,menu,panel}.so.5.[23]
}
