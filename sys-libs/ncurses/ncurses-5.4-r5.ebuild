# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.4-r5.ebuild,v 1.17 2004/12/07 22:31:09 vapier Exp $

inherit eutils flag-o-matic gnuconfig toolchain-funcs

DESCRIPTION="console display library"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
SRC_URI="mirror://gnu/ncurses/${P}.tar.gz"

LICENSE="MIT"
SLOT="5"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="build bootstrap debug doc uclibc unicode nocxx"

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
	gnuconfig_update
}

src_compile() {
	local myconf=

	filter-flags -fno-exceptions

	use debug || myconf="${myconf} --without-debug"

	# Shared objects are compiled properly with -fPIC, but
	# standard libs also require this.
	# Unconditonal use of -fPIC (#55238).
	append-flags -fPIC
	filter-ldflags -pie

	# From version 5.3, ncurses also build c++ bindings, and as
	# we do not have a c++ compiler during bootstrap, disable
	# building it.  We will rebuild ncurses after gcc's second
	# build in bootstrap.sh.
	# <azarah@gentoo.org> (23 Oct 2002)
	( use build || use bootstrap || use nocxx ) \
		&& myconf="${myconf} --without-cxx --without-cxx-binding --without-ada"

	# see note about DEPEND above -- avenj@gentoo.org  2 Apr 04
#	use gpm && myconf="${myconf} --with-gpm"

	# enable utf-8 support
	use unicode && myconf="${myconf} --enable-widec"

	# We need the basic terminfo files in /etc, bug #37026.  We will
	# add '--with-terminfo-dirs' and then populate /etc/terminfo in
	# src_install() ...
	tc-export BUILD_CC
	econf \
		--libdir=/$(get_libdir) \
		--with-terminfo-dirs="/etc/terminfo:/usr/share/terminfo" \
		--disable-termcap \
		--with-shared \
		--with-rcs-ids \
		--without-ada \
		--enable-symlinks \
		--program-prefix="" \
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
	cd ${D}/$(get_libdir)
	dodir /usr/$(get_libdir)
	mv libform* libmenu* libpanel* *.a ${D}/usr/$(get_libdir)

	if use unicode ; then
		gen_usr_ldscript libncursesw.so || die "gen_usr_ldscript failed"
		gen_usr_ldscript libcursesw.so || die "gen_usr_ldscript failed"
		for i in ${D}/usr/$(get_libdir)/*w.*; do
			local libncurses=${i/${D}/}
			dosym ${libncurses} ${libncurses/w./.}
		done
		for i in ${D}/$(get_libdir)/libncursesw.so*; do
			local libncurses=${i/${D}}
			dosym ${libncurses} ${libncurses/w./.}
		done
	else
		# bug #4411
		gen_usr_ldscript libncurses.so || die "gen_usr_ldscript failed"
		gen_usr_ldscript libcurses.so || die "gen_usr_ldscript failed"
	fi

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
	dosym ../share/terminfo /usr/$(get_libdir)/terminfo

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
		cd ${D}/usr/$(get_libdir); rm -f lib{form,menu,panel}*
		cd ${D}/usr/include; rm -f {eti,form,menu,panel}.h
	else
		if use bootstrap ; then
			cd ${D}/usr/$(get_libdir); rm -f lib{form,menu,panel,ncurses++}*
			cd ${D}/usr/include; rm -f {eti,form,menu,panel}.h cursesapp.h curses?.h cursslk.h etip.h
		fi
		# Install xterm-debian terminfo entry to satisfy bug #18486
		LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir):${D}/$(get_libdir) \
			TERMINFO=${D}/usr/share/terminfo \
			${D}/usr/bin/tic ${FILESDIR}/xterm-debian.ti

		if use uclibc ; then
			cp ${D}/usr/share/terminfo/x/xterm-debian ${D}/etc/terminfo/x/
			rm -rf ${D}/usr/share/terminfo/*
		fi

		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO doc/*.doc
		use doc && dohtml -r doc/html/
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
	rm -f ${ROOT}/lib/libncurses.so.5.[23] ${ROOT}/usr/lib/lib{form,menu,panel}.so.5.[23]
	if [ "$(get_libdir)" != "lib" ] ; then
		rm -f ${ROOT}/$(get_libdir)/libncurses.so.5.[23] \
			${ROOT}/usr/$(get_libdir)/lib{form,menu,panel}.so.5.[23]
	fi
}
