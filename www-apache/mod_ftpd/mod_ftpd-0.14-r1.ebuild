# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ftpd/mod_ftpd-0.14-r1.ebuild,v 1.1 2007/09/21 20:35:10 hollow Exp $

inherit apache-module

KEYWORDS="~amd64 ~ppc ~x86"

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
APACHE2_MOD_CONF="0.14-r1/45_${PN}"
APACHE2_MOD_DEFINE="FTPD"

DOCFILES="docs/manual.html AUTHORS ChangeLog NOTICE README TODO"

need_apache2_2

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
