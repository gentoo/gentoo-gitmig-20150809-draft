# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ess/ess-5.2.2-r1.ebuild,v 1.9 2007/01/28 04:11:01 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs Speaks Statistics"
HOMEPAGE="http://stat.ethz.ch/ESS/"
SRC_URI="http://stat.ethz.ch/ESS/downloads/ess/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc sparc x86"

DEPEND="app-text/texi2html
	sys-apps/sed
	virtual/tetex"
RDEPEND=""

SITEFILE=50ess-gentoo.el

src_compile() {
	#einfo "Compiling lisp sources..."
	#pushd ${S}/lisp && make;
	#popd;
	#einfo "Making documentation..."
	# The -glossary option doesn't work with Gentoo texi2html.
	sed "s:-glossary::g" ${S}/doc/Makefile > ${T}/Makefile;
	#mv -f ${T}/Makefile ${S}/doc/Makefile;
	#pushd ${S}/doc && make;
	#popd;
	make PREFIX=/usr \
		INFODIR=/usr/share/info \
		LISPDIR=/usr/share/emacs/site-lisp/ess \
		|| die
}

src_install() {
	make PREFIX=${D}/usr \
		INFODIR=${D}/usr/share/info \
		LISPDIR=${D}/usr/share/emacs/site-lisp/ess \
		install || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE};
	dodir /usr/share/emacs/etc/ess
	cp -pPR etc/* ${D}/usr/share/emacs/etc/ess
	dohtml ${S}/doc/html/*.html
	dodoc ${S}/doc/{NEWS,README,TODO}
	insinto /usr/share/doc/${P}
	doins ${S}/doc/ess-intro.pdf
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see /usr/share/doc/${P} for the complete documentation."
	elog "Usage hints are in /usr/share/emacs/site-lisp/${PN}/ess-site.el."
}

pkg_postrm() {
	elisp-site-regen
}
