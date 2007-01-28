# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ess/ess-5.1.24.ebuild,v 1.9 2007/01/28 04:11:01 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs Speaks Statistics"
HOMEPAGE="http://stat.ethz.ch/ESS/"
SRC_URI="http://stat.ethz.ch/ESS/downloads/ess/OLD/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha sparc"

DEPEND="virtual/emacs
	app-text/texi2html
	sys-apps/sed
	virtual/tetex"
RDEPEND="virtual/emacs"

SITEFILE=50ess-gentoo.el

src_compile() {
	einfo "Compiling lisp sources..."
	pushd ${S}/lisp && make;
	popd;
	einfo "Making documentation..."
	# The -glossary option doesn't work with Gentoo texi2html.
	sed "s:-glossary::g" ${S}/doc/Makefile > ${T}/Makefile;
	mv -f ${T}/Makefile ${S}/doc/Makefile;
	pushd ${S}/doc && make;
	popd;
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc;
	elisp-site-file-install ${FILESDIR}/${SITEFILE};
	doinfo ${S}/doc/*.info*;
	dohtml ${S}/doc/*.html;
	dodoc ${S}/doc/[N-Z]*;
	dodoc ${S}/etc/{sas-keys.ps,ess-sas-sh-command,ess-s?.S}
	insinto /usr/share/doc/${P}
	doins ${S}/doc/ess-intro.pdf
	insinto /usr/share/doc/${P}/examples
	doins ${S}/etc/function-outline.S
	cp -pPR ${S}/etc/other/S-spread ${D}/usr/share/doc/${P}/examples
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see /usr/share/doc/${P} for the complete documentation."
	elog "Usage hints are in /usr/share/emacs/site-lisp/${PN}/ess-site.el."
}

pkg_postrm() {
	elisp-site-regen
}
