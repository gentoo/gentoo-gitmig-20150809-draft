# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gambit/gambit-4.0_beta22.ebuild,v 1.2 2007/05/10 15:19:57 hkbst Exp $

inherit eutils elisp-common check-reqs autotools multilib

MY_PN=gambc
MY_PV=${PV//_beta/b}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="Gambit-C is a native Scheme to C compiler and interpreter."
HOMEPAGE="http://www.iro.umontreal.ca/~gambit/"
SRC_URI="http://www.iro.umontreal.ca/~gambit/download/gambit/4.0/source/${MY_P}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="emacs? ( virtual/emacs )"

SITEFILE="50gambit-gentoo.el"

S=${WORKDIR}/${MY_P}

IUSE="emacs macros gcc-opts"

pkg_setup() {
	if ! use gcc-opts; then
		ewarn "not using gcc specific optimizations"
		ewarn "approximately 0.5GB ram will be needed"
		ewarn "if you experience thrashing, try disabling parallel building"
		# need this much memory in MBytes (does *not* check swap)
		CHECKREQS_MEMORY="768"check_reqs
	else
		ewarn "using gcc specific optimizations."
		ewarn "this will cause approximately 2GB ram to be used instead of 0.5GB."
		ewarn "this will probably cause heavy thrashing of your system."
		# need this much memory in MBytes (does *not* check swap)
		CHECKREQS_MEMORY="2560"	check_reqs
	fi
}

src_unpack() {
	unpack ${A}; cd "${S}"
	sed -e "s:PACKAGE_SUBDIR=\"/${MY_PV}\":PACKAGE_SUBDIR=\"/\":" -i configure.ac
	eautoreconf
}

src_compile() {
	econf --enable-shared --enable-single-host $(use_enable gcc-opts)
	emake || die "emake failed"

	if use emacs; then
		( cd misc; elisp-comp *.el )
	fi

	# uses lots of memory
	if use macros; then
		einfo "compiling syntax-case.scm..."
		einfo "(this may take some time and cause thrashing)"
		time LD_LIBRARY_PATH="lib/" GAMBCOPT="=." gsc/gsc misc/syntax-case.scm
	fi
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF} || die "einstall failed"

	rm ${D}/usr/current

	use macros && dolib syntax-case.*
	mv ${D}/usr/syntax-case.scm ${D}/usr/$(get_libdir)

	# rename the /usr/bin/gsc to avoid collision with gsc from ghostscript
	mv ${D}/usr/bin/gsc ${D}/usr/bin/gsc-gambit

	# remove emacs/site-lisp/gambit.el
	rm -r ${D}/usr/share/emacs
	if use emacs; then
		elisp-install ${PN} misc/*.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi

	dodoc INSTALL.txt README
	insinto /usr/share/doc/${PF}
	doins -r examples

	# create some more explicit names
	dosym gsc-gambit usr/bin/gambit-compiler
	dosym gsi usr/bin/gambit-interpreter

	use macros && dodir /etc/env.d/ && echo "GAMBCOPT=\"=/usr/$(get_libdir)/\"" > ${D}/etc/env.d/50gambit
#		echo '(load "~~syntax-case")' > ${D}/usr/$(get_libdir)/gambcext
}
