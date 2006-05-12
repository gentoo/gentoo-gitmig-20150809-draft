# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ksh/ksh-93.20060214-r1.ebuild,v 1.2 2006/05/12 14:27:56 cretin Exp $

inherit eutils flag-o-matic toolchain-funcs

RELEASE="2006-02-14"
DESCRIPTION="The Original Korn Shell, 1993 revision (ksh93)"
HOMEPAGE="http://www.kornshell.com/"
SRC_URI="nls? ( mirror://gentoo/ast-ksh-locale.${RELEASE}.tgz )
	mirror://gentoo/INIT.${RELEASE}.tgz
	mirror://gentoo/ast-ksh.${RELEASE}.tgz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~arm ~s390 ~ia64 ~ppc ~amd64"
IUSE="nls"

DEPEND="virtual/libc !app-shells/pdksh"

S=${WORKDIR}

src_unpack() {
	# the AT&T build tools look in here for packages.
	mkdir -p ${S}/lib/package/tgz

	# move the packages into place.
	cp ${DISTDIR}/ast-ksh.${RELEASE}.tgz ${S}/lib/package/tgz/ || die

	if use nls; then
		cp ${DISTDIR}/ast-ksh-locale.${RELEASE}.tgz ${S}/lib/package/tgz/ || die
	fi

	# INIT provides the basic tools to start building.
	unpack INIT.${RELEASE}.tgz

	# `package read` will unpack any tarballs put in place.
	${S}/bin/package read || die

	epatch ${FILESDIR}/ksh-20050202-uname.patch
	epatch ${FILESDIR}/ksh-20060124-syntax.patch
}

src_compile() {
	strip-flags; export CCFLAGS="${CFLAGS}"

	cd ${S}; ./bin/package only make ast-ksh CC="$(tc-getCC)" || die

	# install the optional locale data.
	if use nls; then
		cd ${S}; ./bin/package only make ast-ksh-locale CC="$(tc-getCC)"
	fi
}

src_install() {
	exeinto /bin
	doexe ${S}/arch/linux.*/bin/ok/ksh || die

	dosym /bin/ksh /bin/ksh93

	newman ${S}/arch/linux.*/man/man1/sh.1 ksh.1
	dodoc lib/package/LICENSES/ast
	dohtml lib/package/ast-ksh.html

	if use nls; then
		dodir /usr/share
		mv ${S}/share/lib/locale ${D}/usr/share
	fi
}
