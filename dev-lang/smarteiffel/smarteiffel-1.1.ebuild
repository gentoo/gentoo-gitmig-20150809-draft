# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smarteiffel/smarteiffel-1.1.ebuild,v 1.8 2007/08/13 20:16:58 dertobi123 Exp $

#IUSE="doc"
IUSE="doc tcc"

DESCRIPTION="GNU Eiffel compiler"
HOMEPAGE="http://smarteiffel.loria.fr/"

SRC_URI="ftp://ftp.loria.fr/pub/loria/SmartEiffel/se-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc ~sparc ~x86"

DEPEND="tcc? ( >=dev-lang/tcc-0.9.14 )"
#DEPEND="virtual/libc"

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
		#how nioe of them!
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
		echo 1; echo 1; echo SmartEiffel.conf; echo 7 #set conf file
		echo 4 #and saved it
		echo 5; echo
		echo 6; echo #leave the menu
	) | ./install.bin || die
	einfo "finished running install"

	#looks like only one file with path definitions, good
	sed -i -e "s:${S}:${SE_DIR}:" SmartEiffel.conf || die
}

src_install () {
	dodir ${SE_DIR}
	cp -pPR ${S}/{lib,tools,sys,bin} ${D}/${SE_DIR} || die
	cp SmartEiffel.conf ${D}/${SE_DIR}

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
		cp -pPR ${S}/{man,misc,tutorial,READ_ME} ${D}/usr/share/doc/${PF} || die
	fi

	# Setup 'SmartEiffel' environment variable.
	dodir /etc/env.d
	echo "SmartEiffel=${SE_DIR}/SmartEiffel.conf" > ${D}/etc/env.d/20smarteiffel
	echo "SmartEiffelDirectory=${SE_DIR}" >> ${D}/etc/env.d/20smarteiffel
}
