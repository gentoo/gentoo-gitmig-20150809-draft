# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smarteiffel/smarteiffel-2.2.ebuild,v 1.3 2007/08/22 21:29:50 truedfx Exp $

inherit flag-o-matic toolchain-funcs multilib

MY_PV="${PV/./-}"
S="${WORKDIR}/SmartEiffel"

DESCRIPTION="GNU Eiffel compiler"
HOMEPAGE="http://smarteiffel.loria.fr/"
SRC_URI="http://www.loria.fr/~colnet/SmartEiffel/SmartEiffel-${MY_PV/_/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="doc tcc"

DEPEND="tcc? ( >=dev-lang/tcc-0.9.14 )"

# Destination directory to hold most of the SmartEiffel distribution.
SE_DIR="/usr/$(get_libdir)/SmartEiffel"

pkg_setup() {
	# bug #189782
	append-flags $(test-flags -fno-strict-overflow)
}

src_compile() {
	use tcc && CFLAGS=""
	use tcc && COMPILER=tcc || COMPILER="$(tc-getCC)"
	einfo "Using ${COMPILER} as default C-compiler for SmartEiffel!"

	export SmartEiffel="${S}/sys/system.se"
	export PATH="${S}/bin:${PATH}"
	cd ${S}
	ebegin "Compiling install-program"
		${COMPILER} ${CFLAGS} -o install.bin install.c || die
		#package authors created install directory right next to install.c
		#how nice of them!
	eend $?

	einfo "Running install-program"
	(	echo   #skipping stupid prompt
		echo 2 #compiler setup
		use tcc && (
			 echo 11; echo tcc; echo g++
		)
		echo 12 #CFLAGS setup
		echo "${CFLAGS}"
		echo "${CXXFLAGS}"
		echo 0; #main menu
		echo 1; # configure
		echo 1; echo "${S}/sys/system.se"; #set configuration file
		echo 4; echo "${S}/bin/"; # set bin dir
		echo 5; echo "${S}/sys/"; # set Sys dir
		echo 6; echo "${S}/sys/"; # set Short dir
		echo 7; # configure environment variables
		echo 1;
		echo "path_tutorial";
		echo "${S}/tutorial/"
		echo 1;
		echo "path_tools";
		echo "${S}/tools/";
		echo 1;
		echo "path_lib";
		echo "${S}/lib/";
		echo 0;
		echo 0; #exit menu
		echo 5; #save conf file
		echo 6; echo
		echo 0; echo #leave the menu
	) | ./install.bin || die
	einfo "finished running install"

	#looks like only one file with path definitions, good
	sed -i -e "s:${S}:${SE_DIR}:" ${S}/sys/system.se || die
}

src_install () {
	dodir ${SE_DIR}
	cp -pPR ${S}/{lib,tools,sys,bin} ${D}/${SE_DIR} || die

	# Create symlinks to the appropriate executable binaries.
	dodir /usr/bin
	rm ${S}/bin/READ_ME.txt
	#since then this became a bin file?
	for NAME in ${S}/bin/*; do
		NAME="$(basename ${NAME})"
		dosym ${SE_DIR}/bin/${NAME} /usr/bin/${NAME}
	done

	# Install documentation.
	if use doc; then
		einfo "Installing documentation"
		dodir /usr/share/doc/${PF}
		cp -pPR ${S}/{man,misc,tutorial,READ_ME.txt} ${D}/usr/share/doc/${PF} || die
	fi

	# Setup 'SmartEiffel' environment variable.
	dodir /etc/env.d
	echo "SmartEiffel=${SE_DIR}/sys/system.se" > ${D}/etc/env.d/20smarteiffel
	echo "SmartEiffelDirectory=${SE_DIR}" >> ${D}/etc/env.d/20smarteiffel
}
