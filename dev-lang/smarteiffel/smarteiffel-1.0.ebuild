# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smarteiffel/smarteiffel-1.0.ebuild,v 1.4 2003/06/10 08:12:02 msterret Exp $

IUSE="doc"
#IUSE="doc tcc"

DESCRIPTION="GNU Eiffel compiler"
HOMEPAGE="http://smarteiffel.loria.fr/"

SRC_URI="ftp://ftp.loria.fr/pub/loria/SmartEiffel/se-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

#DEPEND="tcc? ( >=dev-lang/tcc-0.9.14 )"
DEPEND="virtual/glibc"

S="${WORKDIR}/SmartEiffel"
# Destination directory to hold most of the SmartEiffel distribution.
SE_DIR="/usr/lib/SmartEiffel"

src_compile() {
	#tcc did not work for me while processing the ebuild
	#commenting out until resolved
	#George Shapovalov <george@gentoo.org>, see #8897

#	use tcc && COMPILER=tcc
#	use tcc || COMPILER=gcc
#	use tcc && CFLAGS=""
	COMPILER=gcc
	einfo "Using ${COMPILER} as default C-compiler for SmartEiffel!"

	export SmartEiffel="${S}/sys/system.se"
	export PATH="${S}/bin:${PATH}"
	cd ${S}
	ebegin "Compiling install-program"
		${COMPILER} ${CFLAGS} -o install install.c || die
	eend $?

	einfo "Running install-program"
	(	echo yes
		echo no
		echo UNIX
		echo ${COMPILER}
		echo ${CFLAGS}
		echo yes
	) | ./install -interactive || die

	# Regenerate a proper loadpath.UNIX file.
	cp sys/loadpath.UNIX sys/loadpath.UNIX.orig
	sed -e "s:^${S}:${SE_DIR}:" \
			sys/loadpath.UNIX.orig > sys/loadpath.UNIX || die
}

src_install () {
	dodir ${SE_DIR}
	cp -a ${S}/{lib,tools,sys,bin} ${D}/${SE_DIR} || die

	# Create symlinks to the appropriate executable binaries.
	dodir /usr/bin
	for NAME in ${S}/bin/*; do
		NAME=`basename ${NAME}`
		dosym ${SE_DIR}/bin/${NAME} /usr/bin/${NAME}
	done

	# Install documentation.
	if [ -n `use doc` ]; then
		einfo "Installing documentation"
		dodir /usr/share/doc/${PF}
		cp -a ${S}/{man,misc,tutorial,READ_ME} ${D}/usr/share/doc/${PF} || die
	fi

	# Setup 'SmartEiffel' environment variable.
	dodir /etc/env.d
	echo "SmartEiffel=${SE_DIR}/sys/system.se" > ${D}/etc/env.d/20smarteiffel
	echo "SmartEiffelDirectory=${SE_DIR}" >> ${D}/etc/env.d/20smarteiffel
}
