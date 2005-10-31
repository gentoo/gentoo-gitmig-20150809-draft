# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jscalltree/jscalltree-2.3.ebuild,v 1.5 2005/10/31 21:59:56 g2boojum Exp $

MY_P=${P/js/}
DESCRIPTION="Static call tree generator for C programs"
HOMEPAGE="http://cdrecord.berlios.de/old/private/index.html"
SRC_URI="ftp://ftp.berlios.de/pub/calltree/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	# No rules file for amd64 but the x86 one seems to work well.
	if use amd64; then
		cd ${S}/RULES
		[ -f x86_64-linux-cc.rul ] || ln -s i586-linux-cc.rul x86_64-linux-cc.rul
	fi
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	OBJ="calltree/OBJ/`ls calltree/OBJ`"
	dobin ${OBJ}/calltree || die "dobin failed"
	doman calltree/calltree.1 || die "doman failed"
	dodoc README COPYING || die "dodoc failed"
}
