# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bestcrypt/bestcrypt-1.5_p9-r1.ebuild,v 1.1 2005/01/04 06:07:29 dragonheart Exp $

inherit flag-o-matic eutils linux-mod toolchain-funcs

MY_PN="bcrypt"
DESCRIPTION="commercially licensed transparent filesystem encryption"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BestCrypt-${PV/_p/-}.tar.gz
	http://www.carceri.dk/files/bcrypt-rc6-serpent.diff.gz"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/linux-sources"

S=${WORKDIR}/bcrypt

#get-version
MODULE_NAMES="bc(block:${S}/mod)
		bc_des(block:${S}/mod/des)
		bc_3des(block:${S}/mod/3des)
		bc_bf128(block:${S}/mod/bf128)
		bc_bf448(block:${S}/mod/bf448)
		bc_blowfish(block:${S}/mod/blowfish)
		bc_cast(block:${S}/mod/cast)
		bc_gost(block:${S}/mod/gost)
		bc_idea(block:${S}/mod/idea)
		bc_rijn(block:${S}/mod/rijn)
		bc_serpent(block:${S}/mod/serpent)
		bc_rc6(block:${S}/mod/rc6)
		bc_twofish(block:${S}/mod/twofish)"

src_unpack() {
	unpack BestCrypt-${PV/_p/-}.tar.gz
	cd ${S}

	epatch ${DISTDIR}/bcrypt-rc6-serpent.diff.gz
	epatch ${FILESDIR}/${P}-makefile_fix.patch
}

src_compile() {

	echo -e "\nmodule: \$(OBJ)" >> mod/Makefile.alg

	filter-flags -fforce-addr
	#BUILD_PARAMS=-I${S}/include KERNEL_DIR=${KV_DIR} -DKBUILD_MODNAME=bc_$$i" TARGET=bc_
	#linux-mod_src_compile

	emake  -C mod SYMSRC=bc_dev${KV_MAJOR}${KV_MINOR}.c bc_dev.ver || die "compile failed"

	emake  -C mod OBJS="bc_dev${KV_MAJOR}${KV_MINOR}.o bc_mgr.o" \
		KERNEL_DIR=${KV_DIR} KEXT=${KV_OBJ} CC=$(tc-getCC) LD=$(tc-getLD) \
		AS=$(tc-getAS) CPP=$(tc-getCXX) || die "compile failed"
	einfo "Modules compiled"


	emake -C kgsha || die "library compile failed"
	emake -C src || die "bctool compile failed"

	#emake -j1 KERNEL_TMP= EXTRA_CFLAGS="${CFLAGS}" EXTRA_CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	linux-mod_src_install

	cd ${S}

	dodir /etc
	cp etc/bc.conf ${D}/etc/bc.conf

	dobin bin/bctool
	insinto /usr/bin
	for link in bcumount bcformat bcfsck bcnew bcpasswd bcinfo \
		bclink bcunlink bcmake_hidden bcreencrypt;
	do
		dosym bctool /usr/bin/${link}
	done


	doman man/bctool.8
	newinitd ${FILESDIR}/bcrypt3 bcrypt
	dodoc README LICENSE HIDDEN_PART

	einfo "If you are using the serpent or rc6 encryption modules and have any problems,"
	einfo "please submit bugs to http://bugs.gentoo.org because these modules are not part"
	einfo "of the standard distribution of BestCrypt for Linux released by Jetico."
	einfo "For more information on these additional modules:"
	einfo "visit http://www.carceri.dk/index.php?redirect=other_bestcrypt"
}
