# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_gzip/mod_gzip-1.3.26.1a-r2.ebuild,v 1.1 2005/01/08 21:29:07 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache module which acts as an Internet Content Accelerator"
HOMEPAGE="http://sourceforge.net/projects/mod-gzip/"
SRC_URI="mirror://sourceforge/mod-gzip/mod_gzip-${PV}.tgz"

KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="GZIP"

need_apache1

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mod-gzip-debug.patch || die
}

src_compile() {
	APXS="${APXS1}" make || die "Make failed"
}
