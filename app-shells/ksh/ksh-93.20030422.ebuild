# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ksh/ksh-93.20030422.ebuild,v 1.2 2003/05/29 11:58:41 taviso Exp $

RELEASE="2003-04-22"
DESCRIPTION="The Original Korn Shell, 1993 revision (ksh93)."
HOMEPAGE="http://www.kornshell.com/"

inherit ccc eutils 

SRC_URI="http://www.research.att.com/~gsf/download/tgz/INIT.${RELEASE}.tgz
	http://www.research.att.com/~gsf/download/tgz/ast-ksh.${RELEASE}.tgz
	http://www.research.att.com/~gsf/download/tgz/ast-ksh-locale.${RELEASE}.tgz"

LICENSE="ATT"
SLOT="0"
KEYWORDS="~x86 ~alpha"

IUSE="static nls"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"
RDEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	# the AT&T build tools look in here for packages.
	mkdir -p ${S}/lib/package/tgz
	
	# move the packages into place.
	cp ${DISTDIR}/ast-ksh.${RELEASE}.tgz ${S}/lib/package/tgz/ || die
	use nls && {
		cp ${DISTDIR}/ast-ksh-locale.${RELEASE}.tgz ${S}/lib/package/tgz/ || die
	}

	# INIT provides the basic tools to start building.
	cd ${S}; unpack INIT.${RELEASE}.tgz || die

	# `package read` will unpack any tarballs put in place.
	${S}/bin/package read || die
}

src_compile() {
	# users who prefer ksh as there regular shell 
	# may want to make it static, so it can be used
	# in the event of fs failure, for example
	# where shared libraries are not available
	use static && append-ldflags -static

	# just a quick message for any users who inadvertantly
	# typed `emerge ksh` but actually wanted `emerge pdksh`
	ewarn "This ebuild will install the original AT&T Korn Shell"
	ewarn "By David Korn, if you were looking for PDKSH, the Public"
	ewarn "Domain Korn SHell, please cancel this emerge and then"
	ewarn "emerge pdksh."
	sleep 3

	# set the optimisations for the build process
	export CCFLAGS="${CFLAGS}"
	cd ${S}; ./bin/package only make ast-ksh CC=${CC:-gcc} || true

	# if we set any optimisations, linking will fail.
	# but this isnt a problem, the optimisations will have already
	# been applied to the object files, we just need to link
	# them.
	einfo "Dont worry about any linker errors above, i need to rerun"
	einfo "the build to complete the linking process..."
	sleep 2 ; unset CCFLAGS

	# re-run to finish linking.
	./bin/package only make ast-ksh CC=${CC:-gcc} || die "sorry, build failed."

	# install the optional locale data.
	# heh, check out locale fudd, or piglatin :)
	#
	# "Too many symbowic winks in paf name twavewsal"
	
	# david korn is a funny guy! :)
	use nls && {
		cd ${S}; ./bin/package only make ast-ksh-locale CC=${CC:-gcc}
	}
}

src_install() {
	# check where the build scripts put them
	local my_arch="${S}/arch/$(${S}/bin/package)"
	mv ${my_arch}/bin/ok/ksh ${my_arch}/bin/ok/ksh93
	exeinto /bin
	doexe ${my_arch}/bin/ok/ksh93
	[ ! -f /bin/ksh ] && dosym /bin/ksh93 /bin/ksh
	# i doubt anyone is fanatical enough to use 
	# this as /bin/sh.
	mv ${my_arch}/man/man1/sh.1 ${my_arch}/man/man1/ksh.1
	doman ${my_arch}/man/man1/ksh.1
	dodoc ${S}/lib/package/LICENSES/ast
	dodoc ${S}/lib/package/gen/ast-ksh.txt
	use nls && {
		dodir /usr/share
		mv ${S}/share/lib/locale ${D}/usr/share
	}
}
