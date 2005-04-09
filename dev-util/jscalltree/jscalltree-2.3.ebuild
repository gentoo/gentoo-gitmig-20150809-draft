# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jscalltree/jscalltree-2.3.ebuild,v 1.4 2005/04/09 08:50:24 blubb Exp $

MY_P=${P/js/}
DESCRIPTION="Static call tree generator for C programs"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/index.html"
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
	make INS_BASE=${D}/usr install || die
	dodoc README README.linux README.gmake COPYING
}
