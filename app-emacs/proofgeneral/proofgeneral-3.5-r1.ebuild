# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/proofgeneral/proofgeneral-3.5-r1.ebuild,v 1.3 2007/07/03 07:30:25 opfer Exp $

SIMPLE_ELISP='nil'
inherit elisp eutils

MY_PN="ProofGeneral"

DESCRIPTION="A generic interface for proof assistants"
HOMEPAGE="http://proofgeneral.inf.ed.ac.uk/"
SRC_URI="http://proofgeneral.inf.ed.ac.uk/releases/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"

SITEFILE=50proofgeneral-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}_isabelle-non-interactive.patch"
}

src_compile() {
	echo "" | emake compile EMACS=emacs
}

src_install() {
	emake install EMACS=emacs PREFIX=${D}/usr

	dohtml doc/*.html doc/*.jpg
	doinfo doc/*.info*
	dodoc README* TODO AUTHORS BUGS CHANGES FAQ INSTALL REGISTER

	# We directly use the site file of the package
	cd "${D}/usr/share/emacs/site-lisp"
	mv site-start.d/pg-init.el ${SITEFILE}

	# clean up
	rmdir site-start.d
	rm -rf "${D}/usr/share/application-registry"
	rm -rf "${D}/usr/share/mime-info"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please register your use of Proof General on the web at:"
	elog "  http://proofgeneral.inf.ed.ac.uk/register "
	elog "(see the REGISTER file for more information)"
}
