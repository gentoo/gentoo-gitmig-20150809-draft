# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ksh/ksh-93.20040229.ebuild,v 1.18 2006/04/21 17:13:34 taviso Exp $

inherit ccc eutils flag-o-matic toolchain-funcs

RELEASE="2004-02-29"
DESCRIPTION="The Original Korn Shell, 1993 revision (ksh93)"
HOMEPAGE="http://www.kornshell.com/"
SRC_URI="http://www.research.att.com/~gsf/download/tgz/INIT.${RELEASE}.tgz
	http://www.research.att.com/~gsf/download/tgz/ast-ksh.${RELEASE}.tgz
	nls? ( http://www.research.att.com/~gsf/download/tgz/ast-ksh-locale.2003-04-22.tgz )"

LICENSE="ATT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ia64 ppc s390 sparc x86"
IUSE="static nls"

DEPEND="virtual/libc !app-shells/pdksh"

S=${WORKDIR}

src_unpack() {
	# the AT&T build tools look in here for packages.
	mkdir -p ${S}/lib/package/tgz

	# move the packages into place.
	cp ${DISTDIR}/ast-ksh.${RELEASE}.tgz ${S}/lib/package/tgz/ || die

	if use nls; then
		cp ${DISTDIR}/ast-ksh-locale.2003-04-22.tgz ${S}/lib/package/tgz/ || die
	fi

	# INIT provides the basic tools to start building.
	unpack INIT.${RELEASE}.tgz

	# `package read` will unpack any tarballs put in place.
	${S}/bin/package read || die
	epatch ${FILESDIR}/ksh-build-problems.diff || die
}

src_compile() {
	# users who prefer ksh as there regular shell
	# may want to make it static, so it can be used
	# in the event of fs failure, for example
	# where shared libraries are not available
	use static && append-ldflags -static

	# set the optimisations for the build process
	export CCFLAGS="${CFLAGS}"
	cd ${S}; ./bin/package only make ast-ksh CC="$(tc-getCC)" || die

	# install the optional locale data.
	# heh, check out locale fudd, or piglatin :)
	#
	# "Too many symbowic winks in paf name twavewsal"

	# david korn is a funny guy! :)
	if use nls; then
		cd ${S}; ./bin/package only make ast-ksh-locale CC=${CC:-gcc}
	fi
}

src_install() {
	# check where the build scripts put them
	local my_arch="${S}/arch/$(${S}/bin/package)"

	exeinto /bin
	doexe ${my_arch}/bin/ok/ksh

	dosym /bin/ksh /bin/ksh93

	newman ${my_arch}/man/man1/sh.1 ksh.1
	dodoc lib/package/LICENSES/ast lib/package/gen/ast-ksh.txt

	if use nls; then
		dodir /usr/share
		mv ${S}/share/lib/locale ${D}/usr/share
	fi
}
