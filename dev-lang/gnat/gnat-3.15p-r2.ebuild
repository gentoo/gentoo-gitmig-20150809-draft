# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-3.15p-r2.ebuild,v 1.1 2003/08/13 22:17:36 george Exp $

DESCRIPTION="GNAT Ada Compiler"
DEPEND="app-shells/tcsh"
RDEPEND=""
SRC_URI="http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-src.tgz
	http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-unx-docs.tar.gz
	http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-i686-pc-redhat71-gnu-bin.tar.gz
	ftp://gcc.gnu.org/pub/gcc/old-releases/gcc-2/gcc-2.8.1.tar.bz2"
HOMEPAGE="http://www.gnat.com/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-2.8.1"
GNATDIR="${WORKDIR}/${P}-src"
GNATBOOT="${WORKDIR}/boot"
GNATBOOTINST="${WORKDIR}/${P}-i686-pc-linux-gnu-bin"

inherit gnat

src_unpack() {
	unpack ${A}

	# Install the bootstrap compiler
	cd "${GNATBOOTINST}"
	echo $'\n'3$'\n'${GNATBOOT}$'\n' | ./doconfig > doconfig.log 2>&1
	./doinstall

	# Prepare the gcc source directory
	cd "${S}"
	patch -p0 < "${GNATDIR}/src/gcc-281.dif"
	touch cstamp-h.in
	mv "${GNATDIR}/src/ada" "${S}"
	cd "${S}/ada"
	bzcat "${FILESDIR}/${P}-gentoo.patch.bz2" | patch -p3
	touch treeprs.ads a-[es]info.h nmake.ad[bs]
}

src_compile() {
	# GCC 2.8.1 doesn't like fancy flags
	local CFLAGS="-O2"

	# Set some paths to our bootstrap compiler.
	local GCC_EXEC_PREFIX="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1"
	local ADA_INCLUDE_PATH="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1/adainclude"
	local ADA_OBJECTS_PATH="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1/adalib"
	local PATH="${GNATBOOT}/bin:${PATH}"
	local LDFLAGS="-L${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1 -L${GNATBOOTINST}"

	# Make $local_prefix point to $prefix
	sed -i -e "s/@local_prefix@/@prefix@/" "${S}/Makefile.in"

	# Configure gcc
	cd "${S}"
	econf --libdir=/usr/lib/ada --program-prefix=gnat \
		|| die "./configure failed"

	# Make sure we don't overwrite the existing gcc
	sed -i -e "s/\$(bindir)\/gcov/\$(bindir)\/gnatgcov/" "${S}/Makefile"
	sed -i -e "s/alias)-gcc/alias)-gnatgcc/g" "${S}/Makefile"

	# Compile it by first using the bootstrap compiler and then bootstrapping
	# our own version. Finally compile the libraries and tools.
	make CC="gcc" LANGUAGES="c ada gcov"
	make CC="gcc" LANGUAGES="c ada gcov" bootstrap
	make CC="gcc" GNATLIBCFLAGS="-O2 -fPIC" gnatlib-shared
	make CC="gcc" gnattools
}

src_install() {
	local PATH="${GNATBOOT}/bin:${PATH}"
	local LDFLAGS="-L${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1 -L${GNATBOOTINST}"

	# Install gnatgcc, tools and native threads library
	make prefix="${D}/usr" libdir="${D}/usr/lib/ada" \
		LANGUAGES="c ada gcov" GCC_INSTALL_NAME=gnatgcc \
		install-common install-libgcc install-gnatlib install-driver || die
	touch "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1/include/float.h"

	# Install the FSU threads library
	cd "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"
	mkdir rts-native
	mkdir rts-fsu

	# Move the native threads library
	mv adalib adainclude rts-native
	cd ${S}

	# Compile and install the FSU threads library
	rm stamp-gnatlib1
	make CC="gcc" CFLAGS="-O2" GNATLIBCFLAGS="-O2 -fPIC" \
		THREAD_KIND="fsu" gnatlib-shared
	make prefix="${D}/usr" libdir="${D}/usr/lib/ada" install-gnatlib
	cd "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"
	mv adalib adainclude rts-fsu
	cd ${S}

	# Install the precompiled FSU library from the binary distribution
	cp "${GNATBOOTINST}/libgthreads.a" "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"
	cp "${GNATBOOTINST}/libmalloc.a" "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"

	# Make native threads the default
	cd "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"
	ln -s rts-native/adalib adalib
	ln -s rts-native/adainclude adainclude

	cp "${GNATBOOTINST}/gnathtml.pl" "${D}/usr/bin"
	chmod +x "${D}/usr/bin"

	# Install documentation and examples
	cd ${WORKDIR}/${P}-src
	dodoc COPYING README
	insinto /usr/share/${PN}/examples
	doins examples/*
	cd ${WORKDIR}/${P}-unx-docs
	rm -f */gvd.*
	rm -f */gdb.*
	for i in `find . -name 'gcc*'`; do \
		mv ${i} ${i/gcc/gnatgcc}; \
	done
	dohtml html/*
	docinto ps
	dodoc ps/*
	docinto txt
	dodoc txt/*
	doinfo info/*
	cd ${S}
	mv gcc.1 gnatgcc.1
	doman gnatgcc.1
}

pkg_postinst() {
	# Notify the user what changed
	einfo ""
	einfo "Both the native-threads and the FSU-threads runtimes have been"
	einfo "installed. The native-threads version is the default on linux."
	einfo "If you want to use FSU-threads (required if you are using Annex D)"
	einfo "simply use the following switch: --RTS=fsu"
	einfo ""
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
	einfo ""
}
