# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mcclim/cl-mcclim-0.9.20040603.ebuild,v 1.2 2004/06/24 23:46:45 agriffis Exp $

inherit common-lisp elisp eutils

DEB_PV=1
THEIR_PV="${PV:0:3}+cvs.${PV:4:4}.${PV:8:2}.${PV:10:2}"

DESCRIPTION="McCLIM is a free software implementation of CLIM."
HOMEPAGE="http://clim.mikemac.com/
	http://clim.mikemac.com/spec/clim.html
	http://packages.debian.org/unstable/devel/cl-mcclim
	http://clim.mikemac.com/spec/clim.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-mcclim/cl-mcclim_${THEIR_PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-mcclim/cl-mcclim_${THEIR_PV}-${DEB_PV}.diff.gz
	mirror://gentoo/cl-mcclim-${THEIR_PV}.gentoo-Spec.tar.gz" # additional sources from CVS for Gentoo
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs doc"

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	dev-lisp/cl-clx-sbcl
	doc? ( media-gfx/transfig
		media-libs/netpbm
		virtual/tetex )
	emacs? ( virtual/emacs )"

CLPACKAGE="mcclim clim-examples"
SITEFILE=${FILESDIR}/${PV}/50mcclim-gentoo.el
ELISP_SOURCES="Tools/Emacs/indent-clim.el Spec/climbols.el"

S=${WORKDIR}/${PN}-${THEIR_PV}.orig

docs-buildable-p() {
#	use doc && test -x /usr/bin/lisp # only CMUCL can build documentation at this time
	false
}

src_unpack() {
	unpack ${A}
	epatch cl-mcclim_${THEIR_PV}-${DEB_PV}.diff
}

src_compile() {
	if use doc; then
		make -C Doc manual.ps
		if docs-buildable-p; then
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
		fi
	fi

	if use emacs; then
		cp ${ELISP_SOURCES} . && elisp-compile *.el
	fi
}

src_install() {
	dodir ${CLSYSTEMROOT}

	for backend in CLX OpenGL PostScript; do
		insinto ${CLSOURCEROOT}/mcclim/Backends/${backend}
		doins Backends/${backend}/*
	done
	for experiment in freetype pprint unzip; do
		insinto ${CLSOURCEROOT}/mcclim/Experimental/${experiment}
		doins Experimental/${experiment}/*
	done
	insinto ${CLSOURCEROOT}/mcclim/Experimental
	doins Experimental/*.lisp

	insinto ${CLSOURCEROOT}/mcclim/Goatee
	doins Goatee/*

	insinto ${CLSOURCEROOT}/mcclim/Lisp-Dep
	doins Lisp-Dep/*

	insinto ${CLSOURCEROOT}/clim-examples/Examples
	doins Examples/*
	insinto ${CLSOURCEROOT}/clim-examples
	doins Goatee/goatee-test.lisp

	insinto ${CLSOURCEROOT}/mcclim
	doins *.lisp debian/mcclim.asd
	dosym ${CLSOURCEROOT}/mcclim/mcclim.asd ${CLSYSTEMROOT}/mcclim.asd

	insinto ${CLSOURCEROOT}/clim-examples/
	doins debian/clim-examples.asd
	dosym ${CLSOURCEROOT}/clim-examples/clim-examples.asd ${CLSYSTEMROOT}/clim-examples.asd

	for system in clim-clx-user clim-clx clim-looks clim; do
		dosym ${CLSYSTEMROOT}/mcclim.asd ${CLSYSTEMROOT}/${system}.asd
	done

	dodoc INSTALL* README TODO Copyright ReleaseNotes/* debian/*README.Debian Webpage/clim-paper.pdf
	do-debian-credits

	if use doc; then
		dodoc Doc/manual.ps
		if docs-buildable-p; then
			insinto /usr/share/doc/${PF}/html/Spec
			doins clim-spec/*
		fi
	fi

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
