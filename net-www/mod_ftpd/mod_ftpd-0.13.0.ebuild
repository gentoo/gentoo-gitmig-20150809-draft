# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ftpd/mod_ftpd-0.13.0.ebuild,v 1.1 2005/01/30 20:16:47 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache2 protocol module which provides an FTP server"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_ftpd/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="gdbm"

DEPEND="gdbm? ( >=sys-libs/gdbm-1.8.0-r5 )"

APACHE2_EXECFILES="providers/*/.libs/*.so"
APACHE2_MOD_CONF="45_${PN}"
APACHE2_MOD_DEFINE="FTPD"

DOCFILES="docs/manual.html AUTHORS ChangeLog NOTICE README TODO"

need_apache2

src_compile() {
	local providers="default fail"

	use gdbm && providers="dbm ${providers}"
	use dbi && providers="dbi ${providers}"

	econf --with-apxs=${APXS2} \
		--enable-providers="${providers}" || die "econf failed"
	emake || die "emake failed"
}