# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ksh/ksh-93.20050202.ebuild,v 1.3 2005/03/28 08:25:42 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs

RELEASE="2005-02-02"
DESCRIPTION="The Original Korn Shell, 1993 revision (ksh93)"
HOMEPAGE="http://www.kornshell.com/"
#SRC_URI="http://www.research.att.com/~gsf/download/tgz/INIT.${RELEASE}.tgz
#	http://www.research.att.com/~gsf/download/tgz/ast-ksh.${RELEASE}.tgz
#	nls? ( http://www.research.att.com/~gsf/download/tgz/ast-ksh-locale.${RELEASE}.tgz )"
SRC_URI="mirror://gentoo/INIT.${RELEASE}.tgz
	mirror://gentoo/ast-ksh.${RELEASE}.tgz
	nls? ( mirror://gentoo/ast-ksh-locale.${RELEASE}.tgz )"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~arm ~s390 ~ia64 ~ppc"
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
}

src_compile() {
	use static && append-ldflags -static

	export CCFLAGS="${CFLAGS}"
	cd ${S}; ./bin/package only make ast-ksh CC="$(tc-getCC)" || die

	# install the optional locale data.
	if use nls; then
		cd ${S}; ./bin/package only make ast-ksh-locale CC=${CC:-gcc}
	fi
}

src_install() {
	# check where the build scripts put them
	local my_arch="${S}/arch/$(${S}/bin/package)"

	exeinto /bin
	doexe ${my_arch}/bin/ok/ksh || die

	dosym /bin/ksh /bin/ksh93

	newman ${my_arch}/man/man1/sh.1 ksh.1
	dodoc lib/package/LICENSES/ast lib/package/gen/ast-ksh.txt

	if use nls; then
		dodir /usr/share
		mv ${S}/share/lib/locale ${D}/usr/share
	fi
}
