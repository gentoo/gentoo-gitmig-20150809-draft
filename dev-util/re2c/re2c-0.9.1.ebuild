# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.9.1.ebuild,v 1.1 2003/06/03 18:04:44 robbat2 Exp $

inherit eutils

DESCRIPTION="re2c is a tool for generating C-based recognizers from regular expressions."
HOMEPAGE="http://www.tildeslash.org/re2c/"
SRC_URI="http://www.tildeslash.org/re2c/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=byacc-1.9"
#RDEPEND="" # Inherited from ${DEPEND}
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A} || die
	# Fix permissions
	chmod -R u+rw ${S}
	epatch ${FILESDIR}/${PV}-patch.gz
}

src_compile() {
	# This gets our C(XX)FLAGS in
	export EXTRA_EMAKE="-e"
	emake || die
}

src_install() {
	doman re2c.1
	dobin re2c
	dodoc CHANGELOG NO_WARRANTY README doc/*
}
