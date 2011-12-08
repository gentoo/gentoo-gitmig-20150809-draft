# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/proofgeneral/proofgeneral-4.1.ebuild,v 1.1 2011/12/08 13:21:03 ulm Exp $

EAPI=4
NEED_EMACS=23

inherit elisp

MY_PN="ProofGeneral"
DESCRIPTION="A generic interface for proof assistants"
HOMEPAGE="http://proofgeneral.inf.ed.ac.uk/"
SRC_URI="http://proofgeneral.inf.ed.ac.uk/releases/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-emacs/mmm-mode-0.4.8-r2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
ELISP_PATCHES="${P}-emacs-24.patch"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	elisp_src_prepare
	sed -i -e '/^OTHER_ELISP/s:contrib/mmm::' Makefile || die
}

src_compile() {
	# remove precompiled lisp files
	emake clean
	emake -j1 compile EMACS=emacs
}

src_install() {
	emake -j1 install EMACS=emacs PREFIX="${D}"/usr
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN} || die

	doinfo doc/*.info*
	doman doc/proofgeneral.1
	dohtml doc/ProofGeneral/*.html doc/PG-adapting/*.html
	dodoc AUTHORS BUGS CHANGES COMPATIBILITY FAQ INSTALL README REGISTER

	# clean up
	rm -rf "${D}/usr/share/emacs/site-lisp/site-start.d"
	rm -rf "${D}/usr/share/application-registry"
	rm -rf "${D}/usr/share/mime-info"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please register your use of Proof General on the web at:"
	elog "  http://proofgeneral.inf.ed.ac.uk/register "
	elog "(see the REGISTER file for more information)"
}
