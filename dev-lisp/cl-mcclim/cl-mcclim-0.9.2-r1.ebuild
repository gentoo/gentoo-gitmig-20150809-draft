# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mcclim/cl-mcclim-0.9.2-r1.ebuild,v 1.3 2007/08/11 17:08:26 beandog Exp $

inherit common-lisp elisp-common eutils

DESCRIPTION="McCLIM is a free software implementation of CLIM."
HOMEPAGE="http://clim.mikemac.com/
	http://clim.mikemac.com/spec/clim.html"
SRC_URI="http://common-lisp.net/project/mcclim/downloads/${P#cl-}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="emacs doc"

DEPEND="dev-lisp/cl-spatial-trees
	dev-lisp/cl-clx
	doc? ( media-gfx/transfig
		media-libs/netpbm
		virtual/tetex )
	emacs? ( virtual/emacs )"

CLPACKAGE="mcclim"
SITEFILE=50${PN}-gentoo.el
ELISP_SOURCES="Tools/Emacs/indent-clim.el"

S=${WORKDIR}/${P#cl-}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-mcclim.asd-cmucl.patch || die
	find ${S} -type f -name \*.cvsignore -exec rm -f '{}' \;
	find ${S} -type d -name CVS -exec rm -rf '{}' \;
}

src_compile() {
	addwrite /var/cache/fonts/
	use doc && make -C Doc manual.ps
	use emacs && cp ${ELISP_SOURCES} . && elisp-comp *.el
}

src_install() {
	dodir ${CLSYSTEMROOT}
	insinto ${CLSOURCEROOT}/mcclim/
	doins -r *.{lisp,asd} \
		Lisp-Dep Goatee Backends Looks Experimental Examples \
		Images					# nothing seems to use Images?
	dosym ${CLSOURCEROOT}/mcclim/mcclim.asd \
		${CLSYSTEMROOT}/mcclim.asd
	for system in clim clim-clx clim-clx-user clim-looks clim-examples; do
		dosym ${CLSYSTEMROOT}/mcclim.asd ${CLSYSTEMROOT}/${system}.asd
	done
	dosym ${CLSOURCEROOT}/mcclim/Experimental/freetype/mcclim-freetype.asd \
		${CLSYSTEMROOT}/mcclim-freetype.asd
	dodoc INSTALL* README TODO Copyright ReleaseNotes/* Webpage/clim-paper.pdf
	use doc && dodoc Doc/manual.ps
	if use emacs; then
		insinto /usr/share/emacs/site-lisp/${PN}
		elisp-install ${PN} *.el *.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	common-lisp_pkg_postinst
}

pkg_postrm() {
	use emacs && elisp-site-regen
	common-lisp_pkg_postrm
}
