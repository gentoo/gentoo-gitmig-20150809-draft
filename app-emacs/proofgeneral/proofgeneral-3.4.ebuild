# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/proofgeneral/proofgeneral-3.4.ebuild,v 1.1 2004/01/21 21:31:09 mattam Exp $

SIMPLE_ELISP='nil'
inherit elisp

IUSE=""

PN="ProofGeneral"
P="$PN-$PV"

DESCRIPTION="Proof General is a generic interface for proof assistants"
HOMEPAGE="http://www.proofgeneral.org/"
SRC_URI="http://www.proofgeneral.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/emacs"

S="${WORKDIR}/${PN}"

SITEFILE=50proofgeneral-gentoo.el

src_compile() {
	einfo "Byte compilation not supported yet (see the INSTALL file)"

}

src_install() {
	for dir in etc generic lego coq isa isar plastic demoisa hol98 phox twelf acl2
	do
		cd $dir
		elisp-install ${PN}/$dir *
		cd ..
	done
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dohtml doc/*.html doc/*.jpg
	doinfo doc/*.info*
	dobin bin/*
	dodoc README* TODO AUTHORS BUGS CHANGES COPYING FAQ INSTALL REGISTER
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please register your use of Proof General on the web at:"
	einfo "  http://www.proofgeneral.org/register "
	einfo "(see the REGISTER file for more information)"
}

pkg_postrm() {
	elisp-site-regen
}
