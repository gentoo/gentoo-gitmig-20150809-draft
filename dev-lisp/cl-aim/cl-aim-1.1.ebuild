# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aim/cl-aim-1.1.ebuild,v 1.2 2005/03/18 07:29:40 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp interface to AOL's TOC instant messaging protocol"
HOMEPAGE="http://claim.sourceforge.net/"
SRC_URI="mirror://sourceforge/claim/claim_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/cl-trivial-sockets"

S=${WORKDIR}/claim_${PV}

CLPACKAGE=claim

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-trivial-sockets-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp claim.asd
	common-lisp-system-symlink
	dodoc LICENSE.txt PROTOCOL.txt README
	docinto examples
	dodoc examples/gossip-bot.lisp
}
