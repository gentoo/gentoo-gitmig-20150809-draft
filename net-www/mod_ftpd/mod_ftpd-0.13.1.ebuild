# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ftpd/mod_ftpd-0.13.1.ebuild,v 1.2 2007/01/25 20:49:50 chtekk Exp $

inherit apache-module

KEYWORDS="~ppc ~x86"

DESCRIPTION="Apache2 module which provides an FTP server."
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_ftpd/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="dbi gdbm"

DEPEND="dbi? ( dev-db/libdbi )
		gdbm? ( sys-libs/gdbm )"
RDEPEND="${DEPEND}"

APACHE2_EXECFILES="providers/*/.libs/*.so"
APACHE2_MOD_CONF="45_${PN}"
APACHE2_MOD_DEFINE="FTPD"

DOCFILES="docs/manual.html AUTHORS ChangeLog NOTICE README TODO"

need_apache2

src_compile() {
	local providers="default fail"

	use dbi && providers="dbi ${providers}"
	use gdbm && providers="dbm ${providers}"

	econf \
		--with-apxs=${APXS2} \
		--enable-providers="${providers}" \
		|| die "econf failed"
	emake || die "emake failed"
}
