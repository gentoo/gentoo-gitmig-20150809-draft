# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smlnj/smlnj-110.43.ebuild,v 1.5 2004/04/24 09:56:05 mattam Exp $

inherit eutils

DESCRIPTION="Standard ML of New Jersey compiler and libraries"
HOMEPAGE="http://cm.bell-labs.com/cm/cs/what/smlnj/"
SRC_URI="ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/config.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/runtime.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/boot.x86-unix.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-lex.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-yacc.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/ml-burg.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/smlnj-lib.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/cml.tgz
	ftp://ftp.research.bell-labs.com/dist/smlnj/working/${PV}/eXene.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

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

	# This patch removes -ansi flags from the x86-linux Makefiles because they conflict
	# with both gcc-3.3 and will cause issues is sysmacros.h is included as well.
	# Closes Bug #30207
	epatch ${FILESDIR}/${P}-gcc33-quirk-fix.patch
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

src_install() {
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

pkg_postinst()
{
	einfo "You need to run env-update to get a working installation"
}
