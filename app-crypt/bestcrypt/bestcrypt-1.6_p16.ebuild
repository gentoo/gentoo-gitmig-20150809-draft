# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bestcrypt/bestcrypt-1.6_p16.ebuild,v 1.2 2008/05/01 15:12:34 maekke Exp $

inherit flag-o-matic eutils linux-mod toolchain-funcs multilib

MY_PN="bcrypt"
MY_PV="${PV/_p/-}"
DESCRIPTION="commercially licensed transparent filesystem encryption"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BestCrypt-${MY_PV}.tar.gz
	!x86? ( mirror://gentoo/bcrypt-rc6-serpent-c.diff.gz )
	x86? ( http://www.carceri.dk/files/bcrypt-rc6-serpent.diff.gz )"

LICENSE="bestcrypt"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="bc(block:"${S}/mod")
		bc_3des(block:"${S}/mod":mod/3des)
		bc_bf128(block:"${S}/mod":mod/bf128)
		bc_bf448(block:"${S}/mod":mod/bf448)
		bc_blowfish(block:"${S}/mod":mod/blowfish)
		bc_cast(block:"${S}/mod":mod/cast)
		bc_des(block:"${S}/mod":mod/des)
		bc_gost(block:"${S}/mod":mod/gost)
		bc_idea(block:"${S}/mod":mod/idea)
		bc_rc6(block:"${S}/mod":mod/rc6)
		bc_rijn(block:"${S}/mod":mod/rijn)
		bc_serpent(block:"${S}/mod":mod/serpent)
		bc_twofish(block:"${S}/mod":mod/twofish)"
	BUILD_TARGETS="all"
	BUILD_PARAMS=" \
		CPP=\"$(tc-getCXX)\" \
		KERNEL_DIR=\"${KV_DIR}\" \
		VER=${KV_MAJOR}.${KV_MINOR} \
		KEXT=${KV_OBJ}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use x86;	then
		epatch "${WORKDIR}/bcrypt-rc6-serpent.diff"
	else
		epatch "${WORKDIR}/bcrypt-rc6-serpent-c.diff"
	fi
}

src_compile() {
	linux-mod_src_compile

	filter-flags -fforce-addr

	emake -C kgsha CPP="$(tc-getCXX)" EXTRA_CXXFLAGS="${CXXFLAGS}" || die "library compile failed"
	emake -C kgsha256 CPP="$(tc-getCXX)"  EXTRA_CXXFLAGS="${CXXFLAGS}" || die "library compile failed"
	emake -C src CC="$(tc-getCC)"  EXTRA_CFLAGS="${CFLAGS} -I../kgsha256" || die "bctool compile failed"
}

src_install() {
	linux-mod_src_install

	dobin bin/bctool
	dolib.so lib/libkgsha{,256}.so
	insinto /usr/bin
	doman man/bctool.8
	for link in bcumount bcformat bcfsck bcnew bcpasswd bcinfo \
			bclink bcunlink bcmake_hidden bcreencrypt; do
		dosym bctool "/usr/bin/${link}"
	done

	insinto /etc
	newins etc/bc.conf bc.conf
	newinitd "${FILESDIR}"/bcrypt3 bcrypt
	dodoc README HIDDEN_PART
}

pkg_postinst() {
	elog "If you are using the serpent or rc6 encryption modules and have any problems,"
	elog "please submit bugs to http://bugs.gentoo.org because these modules are not part"
	elog "of the standard distribution of BestCrypt for Linux released by Jetico."
	elog "For more information on these additional modules:"
	elog "visit http://www.carceri.dk/index.php?redirect=other_bestcrypt"

	ewarn
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"
	ewarn

	linux-mod_pkg_postinst
}
