# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-3.15p-r2.ebuild,v 1.6 2004/04/16 10:20:57 mr_bones_ Exp $

inherit gnat

DESCRIPTION="The GNU Ada Toolkit"
DEPEND="x86? ( >=app-shells/tcsh-6.0 )"
RDEPEND=""
SRC_URI="http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-src.tgz
	http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-unx-docs.tar.gz
	ftp://gcc.gnu.org/pub/gcc/old-releases/gcc-2/gcc-2.8.1.tar.bz2
	x86? ( http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-i686-pc-redhat71-gnu-bin.tar.gz )
	ppc? ( http://dev.gentoo.org/~dholm/files/${P}-powerpc-unknown-linux-gnu.tar.bz2 )"
HOMEPAGE="http://www.gnat.com/"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-2.8.1"
GNATDIR="${WORKDIR}/${P}-src"

case ${ARCH} in
	x86)	GNATBOOT="${WORKDIR}/boot"
			GNATBOOTINST="${WORKDIR}/${P}-i686-pc-linux-gnu-bin"
			;;
	ppc)
			GNATBOOT="${WORKDIR}/${P}-powerpc-unknown-linux-gnu"
			;;
esac

src_unpack() {
	unpack ${A}

	# Install the bootstrap compiler
	if [ "${ARCH}" = "x86" ]; then
		cd "${GNATBOOTINST}"
		echo $'\n'3$'\n'${GNATBOOT}$'\n' | ./doconfig > doconfig.log 2>&1
		./doinstall
	fi

	# Prepare the gcc source directory
	cd "${S}"
	patch -p0 < "${GNATDIR}/src/gcc-281.dif"
	touch cstamp-h.in
	mv "${GNATDIR}/src/ada" "${S}"
	cd "${S}/ada"
	bzcat "${FILESDIR}/${P}-gentoo.patch.bz2" | patch -p3
	touch treeprs.ads a-[es]info.h nmake.ad[bs]

	if [ "${ARCH}" != "x86" ]; then
		cd "${S}"
		bzcat "${FILESDIR}/${P}-gentoo-nonx86.patch.bz2" | patch -p1
	fi
}

src_compile() {
	local PATH="${GNATBOOT}/bin:${PATH}"
	if [ -z ${GNATBOOTINST} ]; then
		local LDFLAGS="-L${GNATBOOTINST}"
	fi

	# Make $local_prefix point to $prefix
	sed -i -e "s/@local_prefix@/@prefix@/" "${S}/Makefile.in"

	# Configure gcc
	local CFLAGS="-O0"
	cd "${S}"
	econf --libdir=/usr/lib/ada --program-prefix=gnat \
		|| die "./configure failed"

	# Make sure we don't overwrite the existing gcc
	sed -i -e "s/\$(bindir)\/gcov/\$(bindir)\/gnatgcov/" "${S}/Makefile"
	sed -i -e "s/alias)-gcc/alias)-gnatgcc/g" "${S}/Makefile"

	# Compile it by first using the bootstrap compiler and then bootstrapping
	# our own version. Finally compile the libraries and tools.
	make CC="gcc" CFLAGS="-O0" LANGUAGES="c ada gcov"
	make CC="gcc" CFLAGS="-O0" LANGUAGES="c ada gcov" bootstrap
	make CC="gcc" CFLAGS="-O0" GNATLIBCFLAGS="-O0 -fPIC" gnatlib-shared
	make CC="gcc" CFLAGS="-O0" gnattools
}

src_install() {
	local PATH="${GNATBOOT}/bin:${PATH}"
	if [ -z ${GNATBOOTINST} ]; then
		local LDFLAGS="-L${GNATBOOTINST}"
	fi

	# Install gnatgcc, tools and native threads library
	make prefix="${D}/usr" libdir="${D}/usr/lib/ada" \
		LANGUAGES="c ada gcov" GCC_INSTALL_NAME=gnatgcc \
		install-common install-libgcc install-gnatlib install-driver || die
	touch "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1/include/float.h"

	if [ "${ARCH}" = "x86" ]; then
		# Install the FSU threads library
		cd "${D}/usr/lib/ada/gcc-lib/${CHOST}/2.8.1"
		mkdir rts-native
		mkdir rts-fsu

		# Move the native threads library
		mv adalib adainclude rts-native
		cd ${S}

		# Compile and install the FSU threads library
		rm stamp-gnatlib1
		make CC="gcc" CFLAGS="-O0" GNATLIBCFLAGS="-O0 -fPIC" \
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
	fi

	if [ -z ${GNATBOOTINST} ]; then
		cp "${GNATBOOTINST}/gnathtml.pl" "${D}/usr/bin"
		chmod +x "${D}/usr/bin"
	fi

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
	if [ "${ARCH}" = "x86" ]; then
		einfo "Both the native-threads and the FSU-threads runtimes have been"
		einfo "installed. The native-threads version is the default on linux."
		einfo "If you want to use FSU-threads (required if you are using"
		einfo "Annex D) simply use the following switch: --RTS=fsu"
		einfo ""
	fi
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
	einfo ""
}
