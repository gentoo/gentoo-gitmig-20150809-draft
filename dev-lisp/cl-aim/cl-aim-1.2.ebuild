# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aim/cl-aim-1.2.ebuild,v 1.1 2006/01/16 19:50:50 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp interface to AOL's TOC instant messaging protocol"
HOMEPAGE="http://claim.sourceforge.net/"
SRC_URI="http://lemonodor.com/code/claim_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"
IUSE=""

DEPEND="dev-lisp/cl-flexi-streams"

S=${WORKDIR}/claim_${PV}

CLPACKAGE=claim

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc LICENSE.txt PROTOCOL.txt README TOC2.txt
	docinto examples
	dodoc examples/gossip-bot.lisp
}
