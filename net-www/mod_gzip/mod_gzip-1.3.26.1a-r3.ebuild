# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_gzip/mod_gzip-1.3.26.1a-r3.ebuild,v 1.6 2007/01/07 16:02:54 kloeri Exp $

inherit eutils apache-module

DESCRIPTION="Apache module which acts as an Internet Content Accelerator"
HOMEPAGE="http://sourceforge.net/projects/mod-gzip/"
SRC_URI="mirror://sourceforge/mod-gzip/mod_gzip-${PV}.tgz"

KEYWORDS="alpha amd64 ppc sparc x86"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"
RDEPEND="${DEPEND}"

APXS1_ARGS="-c mod_gzip.c mod_gzip_debug.c mod_gzip_compress.c"
APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="GZIP"

need_apache1

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mod-gzip-debug.patch || die
}

src_install() {
	apache1_src_install
	dodoc ChangeLog
	dohtml -r docs/manual/
}

