# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/loki_patch/loki_patch-20040916.ebuild,v 1.1 2004/09/21 22:40:09 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Loki Software binary patch tool"
HOMEPAGE="http://www.icculus.org/loki_setup/"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RESTRICT=""
IUSE=""

DEPEND="dev-util/xdelta
		dev-libs/libxml
		games-util/loki_setupdb"

src_compile() {
	./autogen.sh || die "autogen failed."
	EXTRA_ECONF="--with-setupdb=/usr/share/loki_setupdb"
	econf || die "econf failed."
	sed -i -e 's/\.\.\/loki_setupdb/\/usr\/share\/loki_setupdb/' \
		-e -e 's/-I$(SETUPDB)/-I$(SETUPDB)\/include/' Makefile
	emake || die "emake failed"
}

src_install() {
	# no DESTDIR-support in Makefile
	dodir /usr/bin
	exeinto /usr/bin
	doexe loki_patch make_patch || die "doexe failed."
	dodoc CHANGES NOTES README TODO || die "dodoc failed."
}
