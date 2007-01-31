# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smlnj/smlnj-110.45.ebuild,v 1.7 2007/01/31 14:37:37 genone Exp $

inherit eutils

DESCRIPTION="Standard ML of New Jersey compiler and libraries"
HOMEPAGE="http://www.smlnj.org"

SRC_URI="x86? ( mirror://gentoo/${P}-boot.x86-unix.tgz )
ppc? ( mirror://gentoo/${P}-boot.ppc-unix.tgz )
mirror://gentoo/${P}-config.tgz
mirror://gentoo/${P}-MLRISC.tgz
mirror://gentoo/${P}-runtime.tgz
mirror://gentoo/${P}-ml-lex.tgz
mirror://gentoo/${P}-ml-yacc.tgz
mirror://gentoo/${P}-ml-burg.tgz
mirror://gentoo/${P}-smlnj-lib.tgz
mirror://gentoo/${P}-cml.tgz
mirror://gentoo/${P}-eXene.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc"

SMLNJ_DEST="/usr/lib/smlnj"
SMLNJ_TARGETS="./config/targets"

GEN_POSIX_NAMES_PATCH="15i\n#\n.\nj\nw\nq"

ARCH_BOOT="sml.boot.${ARCH}-unix"

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
	export SMLNJ_HOME=${WORKDIR}
	cd ${WORKDIR}

	echo "request ml-burg" >> $SMLNJ_TARGETS
	echo "request eXene" >> $SMLNJ_TARGETS

	LC_ALL=C ./config/install.sh || die
}

src_install() {
	dodir ${SMLNJ_DEST}
	cd ${WORKDIR}

	sed -i -e "s/head -1/head -n 1/" bin/.run-sml

	exeinto ${SMLNJ_DEST}/bin
	doexe bin/{.run-sml,.link-sml,.arch-n-opsys,ml-makedepend,ml-build}

	exeinto ${SMLNJ_DEST}/bin/.run
	doexe bin/.run/*

	insinto ${SMLNJ_DEST}/bin/.heap
	doins bin/.heap/*

	for i in ml-lex ml-yacc sml ml-burg
	  do
	  dosym .run-sml ${SMLNJ_DEST}/bin/$i
	done

	cp -Rp ${WORKDIR}/lib ${D}/${SMLNJ_DEST}

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

pkg_postinst()
{
	elog
	elog "You need to run env-update to get a working installation"
	elog
}
