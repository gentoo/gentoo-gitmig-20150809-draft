# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-5.0_pre20031005.ebuild,v 1.2 2004/04/30 11:12:11 dholm Exp $

inherit gnat

DESCRIPTION="GNAT Ada Compiler"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	x86? ( http://gd.tuwien.ac.at/languages/ada/gnat/3.15p/gnat-3.15p-i686-pc-redhat71-gnu-bin.tar.gz )
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-3.2.3/gcc-core-3.2.3.tar.bz2"
HOMEPAGE="http://www.gnat.com/"

DEPEND="x86? ( >=app-shells/tcsh-6.0 )"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-3.2.3"
GNATBUILD="${WORKDIR}/build"
GNATDIR="${WORKDIR}/${P}"
GNATBOOT="${WORKDIR}/boot"
GNATBOOTINST="${WORKDIR}/gnat-3.15p-i686-pc-linux-gnu-bin"

CFLAGS="-O2 -gnatpgn"

src_unpack() {
	unpack ${A}

	# Install the bootstrap compiler
	cd "${GNATBOOTINST}"
	patch -p1 < ${FILESDIR}/gnat-3.15p-i686-pc-linux-gnu-bin.patch
	echo $'\n'3$'\n'${GNATBOOT}$'\n' | ./doconfig > doconfig.log 2>&1
	./doinstall

	# Prepare the gcc source directory
	cd "${S}"
	mv "${GNATDIR}" "${S}/gcc/ada"
	patch -p0 < "gcc/ada/gcc-32.dif"
	touch gcc/cstamp-h.in
	touch gcc/ada/[es]info.h
	touch gcc/ada/nmake.ad[bs]
	mkdir -p "${GNATBUILD}"
}

src_compile() {
	# Set some paths to our bootstrap compiler.
	local GCC_EXEC_PREFIX="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/3.2.3"
	local PATH="${GNATBOOT}/bin:${PATH}"
	local LDFLAGS="-L${GCC_EXEC_PREFIX} -L${GNATBOOTINST}"
	local CC="${GNATBOOT}/bin/gcc"

	# Configure gcc
	cd "${GNATBUILD}"
	"${S}"/configure --prefix=/usr \
		--program-prefix=gnat \
		--enable-languages="c,ada" \
		--disable-nls \
		--libdir=/usr/lib/ada \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		|| die "configure failed"

	# Compile helper tools
	cd "${GNATBOOT}"
	cp ${S}/gcc/ada/xtreeprs.adb .
	cp ${S}/gcc/ada/xsinfo.adb .
	cp ${S}/gcc/ada/xeinfo.adb .
	cp ${S}/gcc/ada/xnmake.adb .
	gnatmake xtreeprs && \
		gnatmake xsinfo && \
		gnatmake xeinfo && \
		gnatmake xnmake || die "building helper tools"

	for i in `find ${S}/gcc/ada -name '*.ad[sb]'`; do \
		sed -i -e "s/\"gcc\"/\"gnatgcc\"/g" ${i}; \
	done

	# Compile it by first using the bootstrap compiler and then bootstrapping
	# our own version. Finally compile the libraries and tools.
	cd "${GNATBUILD}"
	sed -i -e "s|-laddr2line|${GNATBOOTINST}/libaddr2line.a|" gcc/ada/Makefile
	einfo "Building compiler"
	make CC="gcc" CFLAGS="${CFLAGS}" LANGUAGES="c ada gcov" ||
		die "Failed while running inital compilation!"
	make CC="gcc" CFLAGS="${CFLAGS}" LANGUAGES="c ada gcov" bootstrap ||
		die "Died while bootstrapping!"
	cd "${GNATBUILD}/gcc"
	einfo "Building shared gnatlib"
	make CC="gcc" CFLAGS="${CFLAGS}" GNATLIBCFLAGS="${CFLAGS} -fPIC" \
		gnatlib-shared ||
		die "Failed to build the shared version of gnatlib!"
	einfo "Building gnattools"
	make CC="gcc" CFLAGS="${CFLAGS}" gnattools ||
		die "Failed to build gnattools!"
}

src_install() {
	# Do allow symlinks in /usr/lib/gcc-lib/${CHOST}/3.2.3/include as
	# this can break the build.
	for x in ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	# Install gnatgcc, tools and native threads library
	cd "${GNATBUILD}"
	#make prefix="${D}/usr" libdir="${D}/usr/lib/ada" install \
	#	|| die "installing"
	make prefix=${D}/usr \
		libdir=${D}/usr/lib/ada \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "died while installing"

	# These are all provided by gcc
	rm -rf ${D}/usr/share/info
	rm -rf ${D}/usr/share/man
	rm -rf ${D}/usr/share/make

	dodir "/usr/lib/ada/gcc-lib/${CHOST}/3.2.3/rts-native"

	# Move the native threads library
	cd "${D}/usr/lib/ada/gcc-lib/${CHOST}/3.2.3"
	mv adalib adainclude rts-native

	# Make native threads the default
	ln -s rts-native/adalib adalib
	ln -s rts-native/adainclude adainclude
}

pkg_postinst() {
	# Notify the user what changed
	einfo ""
	einfo "This is a snapshot of the coming GNAT-5.0 based on GCC 3.2.3. It is"
	einfo "not stable and I wouldn't recommend using this version unless you"
	einfo "have a good reason to use it."
	einfo "The version of GNAT in GCC is based on an old patch of GNAT-5.0"
	einfo "which has been crippled by the GCC team to make it less intrusive"
	einfo "in respect of other languages supported by GCC. This snapshot"
	einfo "is the real thing and there is no point whatsoever to compile"
	einfo "GCC with Ada support."
	einfo ""
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
	einfo ""
	einfo "If you are upgrading from GNAT-3.15p or older you will have to"
	einfo "reemerge all Ada packages as GNAT-5.0 has updated to a version of"
	einfo "GCC which is not backwards compatible with 2.8.1."
	einfo ""
}
