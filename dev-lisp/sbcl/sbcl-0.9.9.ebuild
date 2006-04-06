# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.9.9.ebuild,v 1.3 2006/04/06 20:06:21 swegener Exp $

inherit common-lisp-common-2 eutils

BV_X86=0.9.8
BV_PPC=0.8.15
BV_SPARC=0.8.15
BV_MIPS=0.7.10
BV_AMD64=0.9.9

DESCRIPTION="Steel Bank Common Lisp (SBCL) is an implementation of ANSI Common Lisp."
HOMEPAGE="http://sbcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-powerpc-linux-binary.tar.bz2 )
	sparc? ( mirror://sourceforge/sbcl/${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2 )
	mips? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPS}-mips-linux-binary.tar.gz )
	amd64? ( mirror://sourceforge/sbcl/${PN}-${BV_AMD64}-x86-64-linux-binary.tar.bz2 )"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~mips ~amd64"
IUSE="hardened ldb nosource threads nptl unicode"

DEPEND=">=dev-lisp/common-lisp-controller-4
	>=dev-lisp/cl-asdf-1.84
	sys-apps/texinfo"

PROVIDE="virtual/commonlisp"

MY_WORK=${WORKDIR}/files

pkg_setup() {
	if use hardened && gcc-config -c |grep -qv vanilla; then
		while read line; do einfo "${line}"; done <<'EOF'

So-called "hardened" compiler features are incompatible with SBCL. You
must use gcc-config to select a profile with non-hardened features
(the "vanilla" profile) and "source /etc/profile" before continuing.

EOF
		die
	fi
	if ! use nptl && (use x86 || use amd64); then
		while read line; do einfo "${line}"; done <<'EOF'

Building SBCL without NPTL support on at least x86 and amd64
architectures is not a supported configuration in Gentoo.  Please
refer to Bug #119016 for more information.

EOF
		die
	fi
}

src_unpack() {
	local a

	mkdir -p ${MY_WORK}
	cp ${FILESDIR}/${PV}/* ${MY_WORK}
	sed -i "s,/usr/lib,/usr/$(get_libdir),g" ${MY_WORK}/*

	for a in ${A}; do [[ $a == *binary* ]] && break; done
	unpack $a
	mv ${PN}* sbcl-binary || die

	unpack ${P}-source.tar.bz2
	epatch ${MY_WORK}/sbcl-gentoo.patch || die
	sed -i "s,/lib,/$(get_libdir),g" ${S}/install.sh

	cp ${MY_WORK}/customize-target-features.lisp-prefix \
		${S}/customize-target-features.lisp
	if use x86 || use amd64; then
		use threads && echo '(enable :sb-thread)' \
			>>${S}/customize-target-features.lisp
	fi
	use ldb \
		&& echo '(enable :sb-ldb)' \
		>>${S}/customize-target-features.lisp
#	use x86 \
#		&& echo '(enable :sb-futex)' \
#		>>${S}/customize-target-features.lisp
	echo '(disable :sb-test)' >>${S}/customize-target-features.lisp
	! use unicode \
		&& echo '(disable :sb-unicode)' \
		>>${S}/customize-target-features.lisp
	cat ${MY_WORK}/customize-target-features.lisp-suffix \
		>>${S}/customize-target-features.lisp

	find ${S} -type f -name .cvsignore -print0 | xargs -0 rm -f
	find ${S} -depth -type d -name CVS -print0 | xargs -0 rm -rf
	find ${S} -type f -name \*.c -print0 | xargs -0 chmod 644
}

src_compile() {
	local bindir="${WORKDIR}/sbcl-binary"

	LANG=C PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl
			--sysinit /dev/null
			--userinit /dev/null
			--disable-debugger
			--core ${bindir}/output/sbcl.core' \
				|| die
	cd ${S}/doc/manual
	LANG=C make info html || die
}

src_install() {
	unset SBCL_HOME

	insinto /etc/
	doins ${MY_WORK}/sbclrc || die	# Gentoo specific (from Debian)
	dosed "s,/usr/lib/,/usr/$(get_libdir)/,g" /etc/sbclrc

	exeinto /usr/$(get_libdir)/common-lisp/bin
	doexe ${MY_WORK}/sbcl.sh || die	# Gentoo specific (from Debian)

	dodir /usr/share/man
	dodir /usr/share/doc/${PF}
	INSTALL_ROOT=${D}/usr DOC_DIR=${D}/usr/share/doc/${PF} sh install.sh || die
	mv ${D}/usr/$(get_libdir)/sbcl/sbcl.core ${D}/usr/$(get_libdir)/sbcl/sbcl-dist.core || die

	insinto /usr/$(get_libdir)/sbcl
	doins ${MY_WORK}/install-clc.lisp	# Gentoo specific (from Debian)

	doman doc/sbcl-asdf-install.1

	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE SUPPORT TLA TODO
	dodoc ${MY_WORK}/README.Gentoo
	dohtml doc/html/*

	doinfo ${S}/doc/manual/*.info

	keepdir /usr/$(get_libdir)/common-lisp/sbcl

	if ! use nosource; then
		# install the SBCL source
		cp -pPR ${S}/src ${D}/usr/$(get_libdir)/sbcl
		find ${D}/usr/$(get_libdir)/sbcl/src -type f -name \*.fasl -print0 | xargs -0 rm -f
	fi

	impl-save-timestamp-hack sbcl || die
}

pkg_postinst() {
	LANG=C standard-impl-postinst sbcl
}

pkg_postrm() {
	LANG=C standard-impl-postrm sbcl /usr/bin/sbcl
	if [ ! -x /usr/bin/sbcl ]; then
		rm -rf /usr/$(get_libdir)/sbcl/ || die
	fi
}
