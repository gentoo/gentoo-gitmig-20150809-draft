# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bestcrypt/bestcrypt-1.5_p10.ebuild,v 1.6 2005/08/07 11:27:44 dragonheart Exp $

inherit flag-o-matic eutils linux-mod toolchain-funcs

MY_PN="bcrypt"
DESCRIPTION="commercially licensed transparent filesystem encryption"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BestCrypt-${PV/_p/-}.tar.gz
	http://www.carceri.dk/files/bcrypt-rc6-serpent.diff.gz"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="-amd64 x86"

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

	filter-flags -fforce-addr

	emake -C kgsha EXTRA_CXXFLAGS="${CXXFLAGS}" || die "library compile failed"
	emake -C src EXTRA_CFLAGS="${CFLAGS}" || die "bctool compile failed"

	# Don't put stack protection in the kernel - it just is bad
	append-flags -fno-stack-protector-all -fno-stack-protector

	emake  -C mod SYMSRC=bc_dev${KV_MAJOR}${KV_MINOR}.c bc_dev.ver EXTRA_CFLAGS="${CFLAGS}" \
		|| die "compile failed"

	emake  -C mod OBJS="bc_dev${KV_MAJOR}${KV_MINOR}.o bc_mgr.o" \
		KERNEL_DIR=${KV_DIR} KEXT=${KV_OBJ} CC=$(tc-getCC) LD=$(tc-getLD) \
		AS=$(tc-getAS) CPP=$(tc-getCXX) EXTRA_CFLAGS="${CFLAGS}" || die "compile failed"
	einfo "Modules compiled"
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

	insinto /etc/devfs.d
	doins ${FILESDIR}/bestcrypt.devfs
}


pkg_postinst() {

	einfo "If you are using the serpent or rc6 encryption modules and have any problems,"
	einfo "please submit bugs to http://bugs.gentoo.org because these modules are not part"
	einfo "of the standard distribution of BestCrypt for Linux released by Jetico."
	einfo "For more information on these additional modules:"
	einfo "visit http://www.carceri.dk/index.php?redirect=other_bestcrypt"

	einfo
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"

	if [ -e "${ROOT}/dev/.devfsd" ]; then
		killall -HUP devfsd
	fi

	einfo
	linux-mod_pkg_postinst
}
