# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smlnj/smlnj-110.0.7.ebuild,v 1.7 2007/01/31 14:37:37 genone Exp $

inherit eutils

IUSE=""

DESCRIPTION="Standard ML of New Jersey compiler and libraries"

SRC_URI="mirror://gentoo/${P}-bin.x86-unix.tar.Z
mirror://gentoo/${P}-config.tar.Z
mirror://gentoo/${P}-runtime.tar.Z
mirror://gentoo/${P}-ml-lex.tar.Z
mirror://gentoo/${P}-ml-yacc.tar.Z
mirror://gentoo/${P}-ml-burg.tar.Z
mirror://gentoo/${P}-sml-nj.tar.Z
mirror://gentoo/${P}-smlnj-c.tar.Z
mirror://gentoo/${P}-smlnj-lib.tar.Z
mirror://gentoo/${P}-cml.tar.Z
mirror://gentoo/${P}-cm.tar.Z
mirror://gentoo/${P}-eXene.tar.Z"

HOMEPAGE="http://www.smlnj.org/"

LICENSE="BSD"
KEYWORDS="-* x86"

SLOT="0"
DEPEND="virtual/libc"

SMLNJ_DEST="/usr/lib/smlnj"
SMLNJ_TARGETS="./config/targets"

GEN_POSIX_NAMES_PATCH="15i\n#\n.\nj\nw\nq"

ARCH_BOOT="bin.${ARCH}-unix"

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

	# smlnj generates a startup script based on the location of the executables
	# in the filesystem during bootstrapping phase. This solution gets fooled
	# by portage as compilation location is different than installation location.
	# This patch solves this problem:
	epatch ${FILESDIR}/${P}-bindir.patch
}

src_compile() {
	export SMLNJ_HOME=${WORKDIR}
	cd ${WORKDIR}

	./config/install.sh || die
}

src_install () {
	dodir ${SMLNJ_DEST}
	cd ${WORKDIR}

	sed -i -e "s/head -1/head -n 1/" bin/.run-sml

	cp -R bin ${D}/${SMLNJ_DEST}
	cp -R lib ${D}/${SMLNJ_DEST}

	dodir /etc/env.d
	echo -e SMLNJ_HOME=${SMLNJ_DEST} > ${D}/etc/env.d/10smlnj

	#need to provide symlinks into /usr/bin
	dodir /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-burg /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-lex /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-yacc /usr/bin
	dosym ${SMLNJ_DEST}/bin/sml /usr/bin
}

pkg_postinst() {
	elog
	elog "You need to run env-update to get a working installation"
	elog
}
