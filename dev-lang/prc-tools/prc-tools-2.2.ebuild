# Copyright 1999-2003 Gentoo Technologies, Inc. and Tim Yamin [plasmaroo@gentoo.org]
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/prc-tools/prc-tools-2.2.ebuild,v 1.1 2003/09/04 18:05:20 plasmaroo Exp $

DESCRIPTION="GNU-Based Palm C++ Development Suite"

BIN_V="binutils-2.12.1"
GDB_V="gdb-5.3"
GCC_V="gcc-2.95.3"
PRC_X="prc-tools-20030213"

      # A working patch from a non-working CVS snapshot is needed
      # to get GDB to compile under Gentoo 1.2.x. See #23652...

SRC_URI="http://dl.sourceforge.net/sourceforge/prc-tools/${P}.tar.gz
	http://prc-tools.sourceforge.net/misc/${PRC_X}.tar.gz
	ftp://sources.redhat.com/pub/binutils/releases/${BIN_V}.tar.bz2
	ftp://sources.redhat.com/pub/gdb/old-releases/${GDB_V}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/${GCC_V}/${GCC_V}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT=0

HOMEPAGE="http://prc-tools.sourceforge.net"
DEPEND=">=app-text/texi2html-1.64"

S=${WORKDIR}/${P}

src_unpack () {
	 cd ${WORKDIR}
	 unpack ${A} || die

	 cd ${P}
	 ln -s ../${BIN_V} binutils
	 ln -s ../${GDB_V} gdb
	 ln -s ../${GCC_V} gcc
	 cd ..

	 echo ">>> Patching sources..."
	 echo -n " "; epatch ${P}/${BIN_V}.palmos.diff || die
	 echo -n " "; epatch ${PRC_X}/${GDB_V}.palmos.diff || die
	 echo -n " "; epatch ${P}/${GCC_V}.palmos.diff || die
	 echo -n " "; epatch ${FILESDIR}/prc-tools-2.2-compilefix.patch || die

		# This last patch disables dummy headers being copied.
			# a) They're not needed
			# b) This causes a sandboxing error
			# +) Keeps 'palmdev-prep' pointed at the
			#    right place while making the docs install
			#    script from not install them to real root /

}

src_config () {

	cd ..
	mkdir build
	cd build
	# mkdir empty

	echo ">>> Configuring..."
	echo

	# Remove any flags; because the cross-compiler (2.9.x GCC)
	# will not understand any of these optimizations {and will
	# fail} once the cross-compiler compiles the m68k/arm GCC suite

	export ALLOWED_FLAGS="-pipe -0 -01 -02"
	strip-flags

	../${P}/configure --enable-targets=m68k-palmos,arm-palmos \
	--enable-languages=c,c++ \
	--with-headers=${WORKDIR}/build/empty --enable-html-docs \
	--with-palmdev-prefix=/opt/palmdev --prefix=/usr || die

	# These have to be real; otherwise the compiler is hard-coded
	# and tries to find libraries in ${D}/....

	# palmdev-prefix also has to be real; otherwise 'palmdev-prep'
	# defaults to virtual ${D}/..

}

src_compile () {

	src_config
	make || die

}

src_install () {

	cd ..
	cd build
	einstall || die

}

pkg_postinst () {

	echo
	einfo "PRC-Tools is now compiled and installed!"
	einfo "<HTML docs are installed in /opt/palmdev>"
	echo
	einfo "For a complete Palm Development Environment you will also need..."
	echo
	einfo "[ ] PilRC; the Palm resource compiler; emerge pilrc"
	einfo "[ ] POSE; The Palm OS Emulator; emerge pose"
	echo  "   ->> A ROM for POSE; available from Palm"
	einfo "[ ] An SDK; available from the Palm Website"
	echo  "   ->> Decompress this to /opt/palmdev and then run"
	echo  "       'palmdev-prep /opt/palmdev'"
	echo

}
