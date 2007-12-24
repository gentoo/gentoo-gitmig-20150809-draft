# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/dmd-bin/dmd-bin-2.008.ebuild,v 1.1 2007/12/24 20:08:28 anant Exp $

inherit eutils

MY_P=${P/-bin/}
MY_P=${MY_P/-/.}

DESCRIPTION="Digital Mars D Compiler"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/${MY_P}.zip"

LICENSE="DMD"
RESTRICT="mirror strip"
SLOT="0"
KEYWORDS="~x86"

LOC="/opt/dmd"
S="${WORKDIR}"

DEPEND="sys-apps/findutils"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )
	x86? ( sys-libs/libstdc++-v3 )"

src_unpack() {
	unpack "${A}"

	# Remove unneccessary files
	rm -r "${S}/dmd/lib"
	rm -r "${S}/dm"
	rm dmd/license.txt dmd/readme

	# Cleanup line endings
	cd "${S}/dmd"
	edos2unix `find . -name '*.c' -type f`
	edos2unix `find . -name '*.d' -type f`
	edos2unix `find . -name '*.ddoc' -type f`
	edos2unix `find . -name '*.h' -type f`
	edos2unix `find . -name '*.mak' -type f`
	edos2unix `find . -name '*.txt' -type f`
	edos2unix `find samples -name '*.html' -type f`
	edos2unix src/phobos/linux.mak src/phobos/internal/gc/linux.mak

	# Fix permissions and clean up
	fperms guo=r `find . -type f`
	fperms guo=rx `find . -type d`
	fperms guo=rx bin/dmd bin/dumpobj bin/obj2asm bin/rdmd
	mv bin/{dmd,dumpobj,obj2asm,rdmd} .
	rm -r bin/
	mkdir bin
	mkdir lib
	mv ./{dmd,dumpobj,obj2asm,rdmd} bin/
}

src_compile() {
	# Don't use teh bundled library since on gentoo we do teh compile
	cd "${S}/dmd/src/phobos"
	sed -i -e "s:DMD=.*:DMD=${S}/dmd/bin/dmd:" linux.mak internal/gc/linux.mak
	# Can't use emake, customized build system
	make -f linux.mak
	cp obj/release/libphobos2.a "${S}/dmd/lib"

	# Clean up
	make -f linux.mak clean
}

src_install() {
	cd "${S}/dmd"

	# Setup dmd.conf
	cat <<END > "bin/dmd.conf"
[Environment]
DFLAGS=-I/opt/dmd/src/phobos -L-L/opt/dmd/lib
END
	insinto /etc
	doins bin/dmd.conf
	rm bin/dmd.conf

	# Man pages
	doman man/man1/dmd.1
	doman man/man1/dumpobj.1
	doman man/man1/obj2asm.1
	rm -r man

	# Documentation
	dohtml html/d/* html/d/phobos/*
	rm -r html

	# Install
	mkdir "${D}/opt"
	mv "${S}/dmd" "${D}/opt/dmd"

	# Set PATH
	doenvd "${FILESDIR}/25dmd"
}

pkg_postinst () {
	ewarn "You may need to run:                             "
	ewarn "env-update && source /etc/profile                "
	ewarn "to be able to use the compiler immediately.      "
	einfo "                                                 "
	einfo "The bundled sources and samples may be found in  "
	einfo "/opt/dmd/src and /opt/dmd/samples respectively.  "
	einfo "                                                 "
}
