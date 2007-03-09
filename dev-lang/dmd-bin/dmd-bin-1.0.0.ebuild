# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/dmd-bin/dmd-bin-1.0.0.ebuild,v 1.1 2007/03/09 14:56:18 anant Exp $

inherit eutils

MY_P=${P/-bin/}
MY_P=${MY_P/0./0}
MY_P=${MY_P/-/.}

DESCRIPTION="Digital Mars D Compiler"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/${MY_P}.zip"

LICENSE="DMD"
RESTRICT="mirror nostrip"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

LOC="/opt/dmd"
S="${WORKDIR}"

DEPEND="sys-apps/findutils"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )
	x86? ( sys-libs/libstdc++-v3 )"

src_unpack() {
	unpack ${A}

	# Remove unneccessary files
	rm -r ${S}/dm
	rm ${S}/dmd/bin/*.dll ${S}/dmd/bin/*.exe ${S}/dmd/bin/readme.txt
	rm ${S}/dmd/bin/sc.ini ${S}/dmd/bin/windbg.hlp
	rm ${S}/dmd/lib/*.LIB ${S}/dmd/lib/*.lib ${S}/dmd/lib/*.obj
}

src_install() {
	cd ${S}/dmd

	# Cleanup line endings
	edos2unix `find . -name '*.c' -type f`
	edos2unix `find . -name '*.d' -type f`
	edos2unix `find . -name '*.ddoc' -type f`
	edos2unix `find . -name '*.h' -type f`
	edos2unix `find . -name '*.mak' -type f`
	edos2unix `find . -name '*.txt' -type f`
	edos2unix `find samples -name '*.html' -type f`

	# Broken dmd.conf
	# http://d.puremagic.com/issues/show_bug.cgi?id=278
	mv bin/dmd bin/dmd.bin
	cat <<END > "bin/dmd"
#!/bin/sh
${LOC}/bin/dmd.bin -I${LOC}/src/phobos -L${LOC}/lib \$*
END

	# Fix permissions
	fperms guo=r `find . -type f`
	fperms guo=rx `find . -type d`
	fperms guo=rx bin/dmd bin/dmd.bin bin/dumpobj bin/obj2asm bin/rdmd

	# Man pages
	doman man/man1/dmd.1
	doman man/man1/dumpobj.1
	doman man/man1/obj2asm.1
	rm -r man

	# Install
	mkdir "${D}/opt"
	mv "${S}/dmd" "${D}/opt/dmd"

	# Set PATH
	doenvd "${FILESDIR}/25dmd"
}

pkg_postinst () {
	ewarn "The DMD Configuration file has been disabled,"
	ewarn "and will be re-enabled when: "
	ewarn "http://d.puremagic.com/issues/show_bug.cgi?id=278"
	ewarn "has been fixed. Meanwhile, please supply all your"
	ewarn "configuration options in the /opt/dmd/bin/dmd"
	ewarn "shell script."
}
