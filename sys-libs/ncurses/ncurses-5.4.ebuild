# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.4.ebuild,v 1.7 2004/03/29 22:39:30 avenj Exp $

inherit eutils flag-o-matic 64-bit gnuconfig
filter-flags -fno-exceptions

DESCRIPTION="Linux console display library"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
SRC_URI="mirror://gnu/ncurses/${P}.tar.gz"

LICENSE="MIT"
SLOT="5"
KEYWORDS="x86 ~ppc ~sparc alpha hppa ~mips amd64 ia64 ppc64 s390"
IUSE="debug gpm"

DEPEND="virtual/glibc
	!build? ( gpm? ( sys-libs/gpm ) )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-xterm.patch
	# Bug #42336.
	epatch ${FILESDIR}/${P}-share-sed.patch
}

src_compile() {
	local myconf=

	[ -n "`use debug`" ] || myconf="${myconf} --without-debug"

	# Shared objects are compiled properly with -fPIC, but
	# standard libs also require this.
	64-bit && append-flags -fPIC

	# Detect mips systems
	use mips && gnuconfig_update

	# From version 5.3, ncurses also build c++ bindings, and as
	# we do not have a c++ compiler during bootstrap, disable
	# building it.  We will rebuild ncurses after gcc's second
	# build in bootstrap.sh.
	# <azarah@gentoo.org> (23 Oct 2002)
	( use build || use bootstrap ) \
		&& myconf="${myconf} --without-cxx --without-cxx-binding --without-ada"

	use gpm && myconf="${myconf} --with-gpm"

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
		${myconf} || die "configure failed"

	# do not work with -j2 on P4 - <azarah@gentoo.org> (23 Oct 2002)
	make || die "make failed"
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
	for x in dumb linux rxvt screen sun vt{52,100,102,220} xterm
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

	if [ -n "`use build`" ]
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
	else
		# Install xterm-debian terminfo entry to satisfy bug #18486
		LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${D}/usr/lib:${D}/lib \
			TERMINFO=${D}/usr/share/terminfo \
			${D}/usr/bin/tic ${FILESDIR}/xterm-debian.ti

		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
		dodoc doc/*.doc
		dohtml -r doc/html/
	fi
}

pkg_postinst() {
	# Old ncurses may still be around from old build tbz2's.
	rm -f /lib/libncurses.so.5.[23]
	rm -f /usr/lib/lib{form,menu,panel}.so.5.[23]
}
