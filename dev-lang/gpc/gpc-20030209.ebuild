# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gpc/gpc-20030209.ebuild,v 1.4 2003/09/11 01:08:23 msterret Exp $

#inherit flag-o-matic libtool
inherit flag-o-matic

IUSE="nls"

#need to check what gcc version we are running
GCC_PV=$(gcc -dumpversion)

S="${WORKDIR}/gcc-${GCC_PV}"
DESCRIPTION="Gnu Pascal Compiler"
SRC_URI="http://gnu-pascal.de/alpha/${P}.tar.gz
		ftp://gcc.gnu.org/pub/gcc/releases/gcc-${GCC_PV}/gcc-${GCC_PV}.tar.bz2"
#only need gcc-core (smaller download), but user will likely have this one already

HOMEPAGE="http://gnu-pascal.de"

SLOT="0"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		>=sys-devel/gcc-2.95.3"

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
#GCC_PVR=$(emerge -s gcc|grep "installed: 3.2"|cut -d ':' -f 2)
LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${GCC_PV}"
#BINPATH="${LOC}/${CCHOST}/gcc-bin/${GCC_PV}"
DATAPATH="${LOC}/share"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"


src_unpack() {
	unpack "${P}.tar.gz"
	unpack "gcc-${GCC_PV}.tar.bz2"

	cd "${WORKDIR}/${P}/p"

	#comment out read to let ebuild continue
	cp config-lang.in config-lang.in.orig
	sed -e "s:read:#read:" config-lang.in.orig > config-lang.in

	cd "${WORKDIR}/${P}"
	mv p "${S}/gcc/"

	cd "${S}/gcc/p/diffs"
	ln -s gcc-3.2.1.diff gcc-3.2.2.diff
}

src_compile() {
	local myconf

	#lets reduce optimisation somewhat
	replace-flags -O? -O2

	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	#Makefiles seems to use ${P} internally, need to wrap around
	SAVEP="${P}"
	unset P

	einfo "Configuring GCC for GPC inclusion..."
	${S}/configure --prefix=${LOC} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-languages=pascal \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	einfo "Building GPC..."
	# Fix for our libtool-portage.patc
	make LIBPATH="${LIBPATH}" || die "make failed"

	P="${SAVEP}"
}

src_install () {
	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in cd ${S}/gcc/include/*
	do
	if [ -L ${x} ]
	then
		rm -f ${x}
	fi
	done

	einfo "Installing GCC..."

	SAVEP="${P}"
	unset P

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		FAKE_ROOT="${D}" \
		install || die

	#now for the true magic :)
	#gpc is based on gcc and therefore rebuilds gcc backend when compiled
	#we do not want to overwrite it, do we? (even though the binaries are supposed to be the same)
	#so do a dirty hack:
	#go in to the image dir and delete everything inappropriate

	cd ${D}/usr/

	mv bin bin.orig
	mkdir bin
	mv bin.orig/gpc* bin
	rm -rf bin.orig

	#now lib
	cd ${D}/usr/lib/
	rm libiberty.a

	cd ${D}/usr/lib/gcc-lib/i686-pc-linux-gnu/
	mv ${GCC_PV} ${GCC_PV}.orig
	mkdir ${GCC_PV}
	mv ${GCC_PV}.orig/{gpc1,gpcpp,libgpc.a,units} ${GCC_PV}
	mkdir ${GCC_PV}/include
	#mv ${GCC_PV}.orig/include/{gpc-in-c.h,curses.h,mm.h,ncurses.h} ${GCC_PV}/include/
	mv ${GCC_PV}.orig/include/gpc-in-c.h ${GCC_PV}/include/
	rm -rf ${GCC_PV}.orig


	# Install documentation.
	#gpc wants to install some files and a lot of demos under /usr/doc
	#lets move it under /usr/share/doc
	#(Ok, this is not the most buitiful way to do it, but it seems to be the easiest here :))
	cd ${D}/usr/doc
	mkdir -p ${D}/usr/share/doc/${PF}
	mv gpc/* ${D}/usr/share/doc/${PF}
	cd ${D}/usr/share/doc/${PF}
	for fn in *; do [ -f $fn ] && gzip $fn; done

	#clean-up info pages
	cd ${D}/usr/share/info
	rm -rf cpp* gcc*

	#final clean up
	cd ${D}/usr/
	rmdir doc
	rmdir include
	rm -rf share/locale

}
