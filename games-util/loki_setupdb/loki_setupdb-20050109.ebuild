# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/loki_setupdb/loki_setupdb-20050109.ebuild,v 1.4 2006/02/22 07:24:17 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Loki Software product registry database"
HOMEPAGE="http://icculus.org/loki_setup"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/libxml"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	./autogen.sh || "autogen.sh failed"
	econf || die "econf failed"
	emake -j1 all setupdb || die "emake failed"
}

src_install() {
	# the following dir-structure is needed to make sure that
	# loki_setupdb is recognized by loki_patch
	SETUPDB_DIR=usr/share/loki_setupdb/
	dodir ${SETUPDB_DIR}/include
	insinto ${SETUPDB_DIR}/include
	doins *.h || die "doins failed."
	dodir ${SETUPDB_DIR}/${ARCH}
	insinto ${SETUPDB_DIR}/${ARCH}
	doins ${ARCH}/{libsetupdb.a,arch.o,md5.o,setupdb.o} \
		|| die "doins failed."

	dodir /usr/bin
	exeinto /usr/bin
	doexe setupdb || die "doexe failed."
	dodoc CHANGES README || die "dodoc failed."
}
