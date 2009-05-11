# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/lsof/lsof-4.82.ebuild,v 1.1 2009/05/11 06:09:07 vapier Exp $

inherit eutils flag-o-matic fixheadtails toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"
SRC_URI="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.bz2
	ftp://vic.cc.purdue.edu/pub/tools/unix/lsof/${MY_P}.tar.bz2
	ftp://ftp.cerias.purdue.edu/pub/tools/unix/sysutils/lsof/${MY_P}.tar.bz2"

LICENSE="lsof"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="static selinux"

DEPEND="selinux? ( sys-libs/libselinux )"

S=${WORKDIR}/${MY_P}/${MY_P}_src

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	unpack ./${MY_P}_src.tar
	cd "${S}"

	# now patch the scripts to automate everything
	ht_fix_file Configure Customize
	touch .neverInv
	epatch "${FILESDIR}"/${PN}-4.78-answer-config.patch
	sed -i \
		-e "/^LSOF_RANLIB/s:ranlib:$(tc-getRANLIB):" \
		Configure
}

src_compile() {
	use static && append-ldflags -static
	use selinux && export LINUX_HASSELINUX=Y
	export LSOF_CC=$(tc-getCC)
	export LSOF_AR="$(tc-getAR) rc"

	local target="linux"
	use kernel_FreeBSD && target=freebsd
	./Configure ${target} || die "configure failed"
	emake DEBUG="" all || die "emake failed"
}

src_install() {
	dobin lsof || die "dosbin"

	insinto /usr/share/lsof/scripts
	doins scripts/*

	doman lsof.8
	dodoc 00*
}
