# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.3-r8.ebuild,v 1.35 2004/12/07 00:14:39 vapier Exp $

inherit eutils flag-o-matic gcc versionator

# The next command strips most flags from CFLAGS/CXXFLAGS.  If you do 
# not like it, comment it out, but do not file bugreports if you run into
# problems.
do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization ... we'll add -O2 where safe
	filter-flags -O?

	# Compile problems with these (bug #6641 among others)...
	filter-flags -fno-exceptions -fomit-frame-pointer -ggdb

	# Are we trying to compile with gcc3 ?  CFLAGS and CXXFLAGS needs to be
	# valid for gcc-2.95.3 ...
	gcc2-flags
}

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
#MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
#MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"
MY_PV="$(get_version_component_range 1-2)"
MY_PV_FULL="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++/, but in gcc internal directory.
# We will handle /usr/include/g++/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++"

DESCRIPTION="Modern C/C++ compiler written by the GNU people"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha"
IUSE="static nls bootstrap java build"

# Ok, this is a hairy one again, but lets assume that we
# are not cross compiling, than we want SLOT to only contain
# $PV, as people upgrading to new gcc layout will not have
# their old gcc unmerged ...
SLOT="${MY_PV}"

DEPEND="virtual/libc
	>=sys-devel/gcc-config-1.2
	!build? ( >=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext ) )"
RDEPEND="virtual/libc
	>=sys-devel/gcc-config-1.2.3
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

# Hack used to patch Makefiles to install into the build dir
FAKE_ROOT=""

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	libtoolize --copy --force &> /dev/null

	# This new patch for the atexit problem occured with glibc-2.2.3 should
	# work with glibc-2.2.4.  This closes bug #3987 and #4004.
	#
	# Azarah - 29 Jun 2002
	#
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0476.html
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0589.html
	#
	#
	# Something to note, is that this patch makes gcc crash if its given
	# the "-mno-ieee-fp" flag ... libvorbis is an good example of this.
	# This however is on of those which one we want fixed most cases :/
	#
	# Azarah - 30 Jun 2002
	#
	if ! use alpha ; then
		epatch ${FILESDIR}/2.95.3/${P}-new-atexit.diff
	else
		epatch ${FILESDIR}/2.95.3/${P}-alpha.diff
	fi

	# Currently if any path is changed via the configure script, it breaks
	# installing into ${D}.  We should not patch it in src_install() with
	# absolute paths, as some modules then gets rebuild with the wrong
	# paths.  Thus we use $FAKE_ROOT.
	cd ${S}
	for x in $(find . -name Makefile.in)
	do
		# Fix --datadir=
		cp ${x} ${x}.orig
		sed -e 's:datadir = @datadir@:datadir = $(FAKE_ROOT)@datadir@:' \
			${x}.orig > ${x}

		# Fix --bindir=
		cp ${x} ${x}.orig
		sed -e 's:bindir = @bindir@:bindir = $(FAKE_ROOT)@bindir@:' \
			${x}.orig > ${x}

		# Fix --with-gxx-include-dir=
		cp ${x} ${x}.orig
		sed -e 's:gxx_include_dir=${includedir}:gxx_include_dir=$(FAKE_ROOT)${includedir}:' \
			${x}.orig > ${x}

		rm -f ${x}.orig
	done
}

src_compile() {
	local myconf=""
	use build \
		&& myconf="${myconf} --enable-languages=c" \
		|| myconf="${myconf} --enable-shared"
	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	# Make sure we have sane CFLAGS
	do_filter_flags

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-threads=posix \
		--enable-long-long \
		--enable-version-specific-runtime-libs \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Building GCC..."
	if ! use static
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake bootstrap-lean \
			LIBPATH="${LIBPATH}" STAGE1_CFLAGS="-O" || die
		# Above FLAGS optimize and speedup build, thanks
		# to Jeff Garzik <jgarzik@mandrakesoft.com>
	else
		S="${WORKDIR}/build" \
		emake LDFLAGS=-static bootstrap \
			LIBPATH="${LIBPATH}" STAGE1_CFLAGS="-O" || die
	fi
}

src_install() {
	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in cd ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${D}${LOC} \
		bindir=${D}${BINPATH} \
		datadir=${D}${DATAPATH} \
		mandir=${D}${DATAPATH}/man \
		infodir=${D}${DATAPATH}/info \
		LIBPATH="${LIBPATH}" \
		FAKE_ROOT="${D}" \
		install || die

	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"

	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "LDPATH=\"${LIBPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}

	# Install wrappers
	exeinto /lib
	doexe ${FILESDIR}/cpp
	exeinto /usr/bin
	doexe ${FILESDIR}/cc

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if ! use build
	then
		cd ${D}${LIBPATH}

		# Tell libtool files where real libraries are
		for LA in ${D}${LOC}/lib/*.la ${D}${LIBPATH}/../*.la
		do
			if [ -f ${LA} ]
			then
				sed -e "s:/usr/lib:${LIBPATH}:" ${LA} > ${LA}.hacked
				mv ${LA}.hacked ${LA}
				mv ${LA} ${D}${LIBPATH}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${D}${LIBPATH}/../*.{so,a}*
		do
			[ -f ${x} ] && mv -f ${x} ${D}${LIBPATH}
		done

		# These should be symlinks
		cd ${D}${BINPATH}
		rm -f ${CCHOST}-{gcc,g++,c++,g77}
		[ -f gcc ] && ln -sf gcc ${CCHOST}-gcc
		[ -f g++ ] && ln -sf g++ ${CCHOST}-g++
		[ -f g++ ] && ln -sf g++ ${CCHOST}-c++
		[ -f g77 ] && ln -sf g77 ${CCHOST}-g77
	fi

	# This one comes with binutils
	if [ -f ${D}${LOC}/lib/libiberty.a ]
	then
		rm -f ${D}${LOC}/lib/libiberty.a
	fi

	cd ${S}
	if ! use build
	then
		cd ${S}
		docinto /
		dodoc README* FAQ MAINTAINERS
		docinto html
		dodoc faq.html
		docinto gcc
		cd ${S}/gcc
		dodoc BUGS ChangeLog* FSFChangeLog* LANGUAGES NEWS PROBLEMS README* SERVICE TESTS.FLUNK
		cd ${S}/libchill
		docinto libchill
		dodoc ChangeLog
		cd ${S}/libf2c
		docinto libf2c
		dodoc ChangeLog changes.netlib README TODO
		cd ${S}/libio
		docinto libio
		dodoc ChangeLog NEWS README
		cd dbz
		docinto libio/dbz
		dodoc README
		cd ../stdio
		docinto libio/stdio
		dodoc ChangeLog*
		cd ${S}/libobjc
		docinto libobjc
		dodoc ChangeLog README* THREADS*
		cd ${S}/libstdc++
		docinto libstdc++
		dodoc ChangeLog NEWS
	else
		rm -rf ${D}/usr/share/{man,info}
	fi
}

pkg_postinst() {
	if [ "${ROOT}" = "/" -a "${CHOST}" == "${CCHOST}" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${MY_PV_FULL}
	fi
}
