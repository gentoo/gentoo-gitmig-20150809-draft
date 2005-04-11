# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mcclim/cl-mcclim-0.9.1.ebuild,v 1.1 2005/04/11 07:08:39 mkennedy Exp $

inherit common-lisp elisp eutils

DEB_PV=1

DESCRIPTION="McCLIM is a free software implementation of CLIM."
HOMEPAGE="http://clim.mikemac.com/
	http://clim.mikemac.com/spec/clim.html
	http://packages.debian.org/unstable/devel/cl-mcclim
	http://clim.mikemac.com/spec/clim.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-mcclim/cl-mcclim_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-mcclim/cl-mcclim_${PV}-${DEB_PV}.diff.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="emacs doc"

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-clx
	doc? ( media-gfx/transfig
		media-libs/netpbm
		virtual/tetex )
	emacs? ( virtual/emacs )"

CLPACKAGE="mcclim"
# CLPACKAGE="mcclim clim-examples"
SITEFILE=${FILESDIR}/50mcclim-gentoo.el
ELISP_SOURCES="Tools/Emacs/indent-clim.el"

S=${WORKDIR}/${PN}-${PV}.orig

src_unpack() {
	unpack ${A}
	epatch cl-mcclim_${PV}-${DEB_PV}.diff || die
	epatch ${FILESDIR}/${PV}-mcclim.asd-cmucl.patch || die
}

src_compile() {
	use doc && make -C Doc manual.ps
	use emacs && cp ${ELISP_SOURCES} . && elisp-compile *.el
}

src_install() {
	dodir ${CLSYSTEMROOT}
	insinto ${CLSOURCEROOT}/mcclim/
	doins -r *.{lisp,asd} \
		Backends Experimental Goatee Lisp-Dep Looks Examples \
		debian/clim-examples.asd
	dosym ${CLSOURCEROOT}/mcclim/mcclim.asd \
		${CLSYSTEMROOT}/mcclim.asd
	dosym ${CLSOURCEROOT}/mcclim/mcclim-examples.asd \
		${CLSYSTEMROOT}/mcclim-examples.asd
	for system in clim clim-clx clim-clx-user clim-looks; do
		dosym ${CLSYSTEMROOT}/mcclim.asd ${CLSYSTEMROOT}/${system}.asd
	done
	dodoc debian/README* INSTALL* README TODO Copyright ReleaseNotes/* Webpage/clim-paper.pdf
	use doc && dodoc Doc/manual.ps
	if use emacs; then
		insinto /usr/share/emacs/site-lisp/${PN}
		doins *.el *.elc
		elisp-site-file-install ${SITEFILE}
	fi
	do-debian-credits
}

pkg_postinst() {
	elisp_pkg_postinst
	common-lisp_pkg_postinst
}

pkg_postrm() {
	elisp_pkg_postinst
	common-lisp_pkg_postrm
}
