# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mcclim/cl-mcclim-0.9.ebuild,v 1.5 2004/07/14 15:55:26 agriffis Exp $

inherit common-lisp elisp eutils

DESCRIPTION="McCLIM is a free software implementation of CLIM."
HOMEPAGE="http://clim.mikemac.com/ http://clim.mikemac.com/spec/clim.html"
SRC_URI="http://clim.mikemac.com/downloads/snapshots/src/McCLIM-${PV}.tgz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc emacs"

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	dev-lisp/cl-clx-sbcl
	doc? ( media-gfx/transfig
		media-libs/netpbm
		virtual/tetex )
	emacs? ( virtual/emacs )"

CLPACKAGE="clim clim-clx clim-examples"
SITEFILE=${FILESDIR}/50mcclim-gentoo.el

S=${WORKDIR}/McCLIM

ELISP_SOURCES="Tools/Emacs/indent-clim.el Spec/climbols.el"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/system.lisp-gentoo.patch
	mkdir ${S}/clim-spec
}

src_compile() {
	if use doc; then
		make -C Doc manual.ps
		if [ -x /usr/bin/lisp ]; then
			lisp -batch -noinit -nosite-init -eval "
(progn
  (compile-file \"Tools/gilbert/clim-doc-convert\")
  (quit))"
			lisp -batch -noinit -nositeinit \
				-load Tools/gilbert/clim-doc-convert \
				-eval "
(progn
  (defparameter clim-doc-convert::*mcclim-base-dir* \"${S}/\")
  (defparameter clim-doc-convert::*output-directory* \"${S}/clim-spec/\")
  (clim-doc-convert:run)
  (quit))"
		elif [ -x /usr/bin/sbcl ]; then
			ewarn "Documentation cannot be built with SBCL at this time"
		elif [ -x /usr/bin/clisp ]; then
			ewarn "Documentation cannot be built with CLISP at this time"
		fi
	fi

	if use emacs; then
		cp ${ELISP_SOURCES} .
		elisp-compile *.el
	fi
}

src_install() {
	insinto /usr/share/common-lisp/source/clim
	doins *.lisp
	for i in Apps Backends Examples Experimental Goatee Images Lisp-Dep Looks; do
		cp -r ${i} ${D}/usr/share/common-lisp/source/clim/
	done
	dodir /usr/share/common-lisp/systems/

	dosym /usr/share/common-lisp/source/clim/system.lisp /usr/share/common-lisp/systems/clim.asd

	for i in clim-clx clim-examples; do
		dosym /usr/share/common-lisp/source/clim /usr/share/common-lisp/source/${i}
		dosym /usr/share/common-lisp/source/${i}/system.lisp  /usr/share/common-lisp/systems/${i}.asd
	done

	dodoc README TODO INSTALL*

	if use doc; then
		dodoc Doc/manual.ps
		insinto /usr/share/doc/${PF}/html/Spec
		doins clim-spec/*
	fi

	find ${D} -type d -name CVS -print |xargs rm -rf

	if use emacs; then
		insinto /usr/share/emacs/site-lisp/${PN}
		doins *.el *.elc
		elisp-site-file-install ${SITEFILE}
	fi
}

pkg_postinst() {
	elisp_pkg_postinst
	common-lisp_pkg_postinst
}

pkg_postrm() {
	elisp_pkg_postinst
	common-lisp_pkg_postrm
}
