# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smlnj/smlnj-110.67-r1.ebuild,v 1.1 2007/11/18 17:50:49 hkbst Exp $

inherit eutils

DESCRIPTION="Standard ML of New Jersey compiler and libraries"
HOMEPAGE="http://www.smlnj.org"

#BASE_URI="http://smlnj.cs.uchicago.edu/dist/working/${PV}/"
BASE_URI="mirror://gentoo/${P}-"

#Use the fetch_files.sh script in subdir files/ to fetch and
#version these files if they aren't on Gentoo mirrors.
#For example if you're doing a local bump.
FILES="
config.tgz

cm.tgz
compiler.tgz
runtime.tgz
system.tgz
MLRISC.tgz
smlnj-lib.tgz

ckit.tgz
nlffi.tgz

cml.tgz
eXene.tgz

ml-lex.tgz
ml-yacc.tgz
ml-burg.tgz
ml-lpt.tgz

pgraph.tgz
trace-debug-profile.tgz

heap2asm.tgz

smlnj-c.tgz
"

#use amd64 in 32-bit mode
SRC_URI="amd64? ( ${BASE_URI}boot.x86-unix.tgz )
		 ppc?   ( ${BASE_URI}boot.ppc-unix.tgz )
		 sparc? ( ${BASE_URI}boot.sparc-unix.tgz )
		 x86?   ( ${BASE_URI}boot.x86-unix.tgz )"

for file in ${FILES}; do
	SRC_URI+=" ${BASE_URI}${file} "
done

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}"

#SMLNJ_DEST="/usr/lib/smlnj"
#SMLNJ_TARGETS="./config/targets"

#GEN_POSIX_NAMES_PATCH="15i\n#\n.\nj\nw\nq"

#ARCH_BOOT="sml.boot.${ARCH}-unix"

src_unpack() {
	mkdir -p "${S}"
	for file in ${A}; do
		[[ ${file} != ${P}-config.tgz ]] && mv "${DISTDIR}/${file}" "${S}/${file#${P}-}"
	done
	unpack ${P}-config.tgz && rm config/*.bat
	echo SRCARCHIVEURL=\"file:/${S}\" > "${S}"/config/srcarchiveurl
}

src_compile() {
#	echo "request ml-burg" >> $SMLNJ_TARGETS
#	echo "request eXene" >> $SMLNJ_TARGETS

	SMLNJ_HOME="${S}" ./config/install.sh || die "compilation failed"
}

_src_install() {
	insinto /usr
	doins -R bin lib
}

src_install() {
	mkdir -p "${D}"/usr
	mv {bin,lib} "${D}"/usr

	for file in "${D}"/usr/bin/{*,.*}; do
		[[ -f ${file} ]] && sed "2iSMLNJ_HOME=/usr" -i ${file}
#		[[ -f ${file} ]] && sed "s:${WORKDIR}:/usr:" -i ${file}
	done
}

_src_install() {
	dodir ${SMLNJ_DEST}
	cd "${WORKDIR}"

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

	cp -Rp "${WORKDIR}"/lib "${D}/${SMLNJ_DEST}"

	dodir /etc/env.d
	echo -e SMLNJ_HOME=${SMLNJ_DEST} > "${D}"/etc/env.d/50smlnj

	#need to provide symlinks into /usr/bin
	dodir /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-build /usr/bin/
	dosym ${SMLNJ_DEST}/bin/ml-burg /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-lex /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-makedepend /usr/bin
	dosym ${SMLNJ_DEST}/bin/ml-yacc /usr/bin
	dosym ${SMLNJ_DEST}/bin/sml /usr/bin
}
