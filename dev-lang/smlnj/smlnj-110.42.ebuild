# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smlnj/smlnj-110.42.ebuild,v 1.2 2003/09/11 01:08:24 msterret Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Standard ML of New Jersey compiler and libraries"
SRC_URI="ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/config.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/runtime.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/boot.x86-unix.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-lex.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-yacc.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-burg.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/smlnj-lib.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/cml.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/eXene.tgz"

HOMEPAGE="http://cm.bell-labs.com/cm/cs/what/smlnj/"

LICENSE="BSD"
KEYWORDS="~x86"

SLOT="0"
DEPEND="virtual/glibc"

SMLNJ_DEST="/usr/share/smlnj"
SMLNJ_TARGETS="./config/targets"

GEN_POSIX_NAMES_PATCH="15i\n#\n.\nj\nw\nq"

ARCH_BOOT="sml.boot.x86-unix"

src_unpack() {
	unpack ${A}

	dirs=`ls ${WORKDIR}`
	mkdir ${WORKDIR}/src

	for i in $dirs; do
		if test "$i" != "config" -a "$i" != ${ARCH_BOOT}; then
			mv ${WORKDIR}/${i} ${WORKDIR}/src
		fi
	done

	printf ${GEN_POSIX_NAMES_PATCH} | ed -s ${WORKDIR}/src/runtime/config/gen-posix-names.sh
}

src_compile() {
	if test "${SMLNJ_HOME}" != ""; then
		SMLNJ_HOME=""
	fi

	cd ${WORKDIR}

	echo "request ml-burg" >> $SMLNJ_TARGETS
	echo "request cml" >> $SMLNJ_TARGETS
	echo "request cml-lib" >> $SMLNJ_TARGETS
	echo "request eXene" >> $SMLNJ_TARGETS

	./config/install.sh || die
}

src_install () {

	dodir ${SMLNJ_DEST}

	cp -r ${WORKDIR}/{bin,lib} ${D}${SMLNJ_DEST} || die

	dodir /etc/env.d
	echo -e SMLNJ_HOME=${SMLNJ_DEST} > ${D}/etc/env.d/10smlnj

	#need to provide symlinks into /usr/bin
	dodir /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-build /usr/bin/
	dosym ${SMLNJ_DEST}/bin/ml-burg /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-lex /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-makedepend /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-yacc /usr/bin
	dosym ${SMLNJ_DEST}/bin/sml /usr/bin

}
