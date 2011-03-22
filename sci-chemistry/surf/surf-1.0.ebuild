# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/surf/surf-1.0.ebuild,v 1.3 2011/03/22 14:06:08 xarthisius Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Solvent accesible Surface calculator"
HOMEPAGE="http://www.ks.uiuc.edu/"
SRC_URI="http://www.ks.uiuc.edu/Research/vmd/extsrcs/surf.tar.Z -> ${P}.tar.Z"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE=""

DEPEND="x11-misc/makedepend"
RDEPEND=""

S=${WORKDIR}

src_prepare() {
	sed \
		-e 's:$(CC) $(CFLAGS) $(OBJS):$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS):g' \
		-i Makefile || die
}

src_compile() {
	emake depend \
		&& emake \
			CC="$(tc-getCC)" \
			OPT_CFLAGS="${CFLAGS} \$(INCLUDE)" \
			CFLAGS="${CFLAGS} \$(INCLUDE)" \
			|| die
}

src_install() {
	dobin ${PN} || die
	dodoc README || die
}
