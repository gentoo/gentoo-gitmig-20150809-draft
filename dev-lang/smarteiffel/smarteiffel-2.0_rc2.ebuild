# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smarteiffel/smarteiffel-2.0_rc2.ebuild,v 1.2 2004/10/23 14:03:31 weeve Exp $

IUSE="doc tcc"

MY_PV=${PV//./-}

DESCRIPTION="GNU Eiffel compiler"
HOMEPAGE="http://smarteiffel.loria.fr/"

SRC_URI="ftp://ftp.loria.fr/pub/loria/SmartEiffel/se.latest/se-${MY_PV//_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"

DEPEND="tcc? ( >=dev-lang/tcc-0.9.14 )"

S="${WORKDIR}/SmartEiffel"
# Destination directory to hold most of the SmartEiffel distribution.
SE_DIR="/usr/lib/SmartEiffel"

src_compile() {
	use tcc && CFLAGS=""
	use tcc && COMPILER=tcc || COMPILER=gcc
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
		echo 13 #main menu
		echo 1; # configure
		echo 1; echo "${S}/sys/system.se"; #set configuration file
		echo 3; echo "${S}/bin/"; # set bin dir
		echo 4; echo "${S}/sys/"; # set Sys dir
		echo 5; echo "${S}/sys/"; # set Short dir
		echo 6; # configure environment variables
		echo 1;
		echo "path_tutorial";
		echo "${S}/tutorial/"
		echo 1;
		echo "path_tools";
		echo "${S}/tools/";
		echo 1;
		echo "path_lib";
		echo "${S}/lib/";
		echo 3;
		echo 8 #exit menu
		echo 4 #save conf file
		echo 5; echo
		echo 6; echo #leave the menu
	) | ./install.bin || die
	einfo "finished running install"

	#looks like only one file with path definitions, good
	sed -i -e "s:${S}:${SE_DIR}:" ${S}/sys/system.se || die
}

src_install () {
	dodir ${SE_DIR}
	cp -a ${S}/{lib,tools,sys,bin} ${D}/${SE_DIR} || die

	# Create symlinks to the appropriate executable binaries.
	dodir /usr/bin
	rm ${S}/bin/README.txt
	#since then this became a bin file?
	for NAME in ${S}/bin/*; do
		NAME=`basename ${NAME}`
		dosym ${SE_DIR}/bin/${NAME} /usr/bin/${NAME}
	done

	# Install documentation.
	if use doc; then
		einfo "Installing documentation"
		dodir /usr/share/doc/${PF}
		cp -a ${S}/{man,misc,tutorial,READ_ME} ${D}/usr/share/doc/${PF} || die
	fi

	# Setup 'SmartEiffel' environment variable.
	dodir /etc/env.d
	echo "SmartEiffel=${SE_DIR}/sys/system.se" > ${D}/etc/env.d/20smarteiffel
	echo "SmartEiffelDirectory=${SE_DIR}" >> ${D}/etc/env.d/20smarteiffel
}
