# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-3.14p.ebuild,v 1.1 2003/06/17 21:51:48 george Exp $
#
# Never replace this with the Ada compiler in the gcc tree. They are based
# on the same source but this is the official validated compiler from ACT.
# The one in gcc (3-branch) is currently broken!
# If you want to try that one install it under a different name and use
# gnatmake --GCC=othername (if you use gnatmake).
# The official statement from ACT is that they will continiue to release
# GNAT, so they will release a version based on gcc 3 when it is working.
#
# It is possible to at least install this on sparc too, I have seen
# unofficial bootstrap compilers for ppc as well. As I don't have access to
# a sparc or a ppc running linux I won't try to add support for them.
# If you have access to any of these it should be fairly easy to add support
# for it.
#

DESCRIPTION="GNAT Ada Compiler"
DEPEND="app-shells/tcsh"
RDEPEND=""
SRC_URI="http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-src.tgz
	http://gd.tuwien.ac.at/languages/ada/gnat/${PV}/${P}-i686-pc-linux-gnu-bin.tar.gz
	ftp://gcc.gnu.org/pub/gcc/old-releases/gcc-2/gcc-2.8.1.tar.bz2"
HOMEPAGE="http://www.gnat.com/"

SLOT="GNAT-3.14p"
KEYWORDS="~x86"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-2.8.1"
GNATDIR="${WORKDIR}/${P}-src"
GNATBOOT="${WORKDIR}/boot"
GNATBOOTINST="${WORKDIR}/${P}-i686-pc-linux-gnu-bin"

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
	for i in `find ${S}/ada -name '*.ad[sb]'`; do \
		sed -i -e "s/\"gcc\"/\"gnatgcc\"/g" ${i}; \
	done
	cd "${S}/ada"
	touch treeprs.ads a-[es]info.h nmake.ad[bs]
}

src_compile() {
	# GCC 2.8.1 doesn't like fancy flags
	export CFLAGS="-O2"

	# Set some paths to our bootstrap compiler.
	export GCC_EXEC_PREFIX="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1"
	export ADA_INCLUDE_PATH="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1/adainclude"
	export ADA_OBJECTS_PATH="${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1/adalib"
	OLDPATH="${PATH}"
	export PATH="${GNATBOOT}/bin:${PATH}"
	export LDFLAGS="-L${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1 -L${GNATBOOTINST}"

	# Make $local_prefix point to $prefix
	sed -i -e "s/@local_prefix@/@prefix@/" "${S}/Makefile.in"

	# Configure gcc
	cd "${S}"
	./configure --prefix=/usr --program-prefix=gnat \
		--host="${CHOST}" --build="${CHOST}" --target="${CHOST}" \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	# Make sure we don't overwrite the existing gcc
	sed -i -e "s/\$(bindir)\/gcov/\$(bindir)\/gnatgcov/" "${S}/Makefile"
	sed -i -e "s/alias)-gcc/alias)-gnatgcc/g" "${S}/Makefile"

	# Compile it by first using the bootstrap compiler and then bootstrapping
	# our own version. Finally compile the libraries and tools.
	make CC="gcc" LANGUAGES="c ada gcov"
	make CC="gcc" LANGUAGES="c ada gcov" bootstrap
	make CC="gcc" GNATLIBCFLAGS="${CFLAGS}" gnatlib
	make CC="gcc" gnattools
}

src_install() {
	export PATH="${GNATBOOT}/bin:${PATH}"
	export LDFLAGS="-L${GNATBOOT}/lib/gcc-lib/i686-pc-linux-gnu/2.8.1 -L${GNATBOOTINST}"

	# Install gnatgcc, tools and native threads library
	make prefix="${D}/usr" \
		LANGUAGES="c ada gcov" GCC_INSTALL_NAME=gnatgcc \
		install-common install-libgcc install-gnatlib install-driver || die
	touch "${D}/usr/lib/gcc-lib/${CHOST}/2.8.1/include/float.h"


	# Install the FSU threads library
	cd "${D}/usr/lib/gcc-lib/${CHOST}/2.8.1"
	mkdir rts-native
	mkdir rts-fsu

	# Copy the native threads library
	cp -r adalib rts-native
	cp -r adainclude rts-native
	#remove circular symlinks
	cd rts-native/adalib/
	rm -f libgnarl.so libgnat.so
	cd "${S}"
	rm stamp-gnatlib1


	# Compile and install the FSU threads library
	make CC=gcc CFLAGS="-O2" GNATLIBCFLAGS="-fPIC -O2" THREAD_KIND=fsu gnatlib
	make prefix="${D}/usr" install-gnatlib
	cd "${D}/usr/lib/gcc-lib/${CHOST}/2.8.1"
	mv adalib adainclude rts-fsu
	cd rts-fsu/adalib/
	rm -f libgnarl.so libgnat.so

	# Install the precompiled FSU library from the binary distribution
	cp "${GNATBOOTINST}/libgthreads.a" "${D}/usr/lib/gcc-lib/${CHOST}/2.8.1"
	cp "${GNATBOOTINST}/libmalloc.a" "${D}/usr/lib/gcc-lib/${CHOST}/2.8.1"

	# Make native threads the default
	dosym /usr/lib/gcc-lib/${CHOST}/2.8.1/rts-native/adalib \
		/usr/lib/gcc-lib/${CHOST}/2.8.1/
	dosym /usr/lib/gcc-lib/${CHOST}/2.8.1/rts-native/adainclude \
		/usr/lib/gcc-lib/${CHOST}/2.8.1/

	cp "${GNATBOOTINST}/gnathtml.pl" "${D}/usr/bin"
	chmod +x "${D}/usr/bin"
}

pkg_postinst() {
	# Notify the user what changed
	einfo ""
	einfo "Both the native-threads and the FSU-threads libraries have been"
	einfo "installed. The native-threads version is the default on linux."
	einfo "If you want to use FSU-threads (required if you are using Annex D)"
	einfo "you must set the following two environment variables:"
	einfo "ADA_INCLUDE_PATH=/usr/lib/gcc-lib/${CHOST}/2.8.1/rts-fsu/adainclude:\$ADA_INCLUDE_PATH"
	einfo "ADA_OBJECTS_PATH=/usr/lib/gcc-lib/${CHOST}/2.8.1/rts-fsu/adalib:\$ADA_OBJECTS_PATH"
	einfo "or use the -aI/usr/lib/gcc-lib/${CHOST}/2.8.1/rts-fsu/adainclude"
	einfo "-aO/usr/lib/gcc-lib/${CHOST}/2.8.1/rts-fsu/adalib"
	einfo "or you can give gnatmake the following switch: --RTS=fsu"
	einfo ""
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
	einfo ""
}
