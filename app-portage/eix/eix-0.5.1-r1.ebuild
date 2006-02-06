# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.5.1-r1.ebuild,v 1.2 2006/02/06 07:48:07 corsair Exp $

inherit eutils

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://dev.croup.de/proj/eix"
SRC_URI="http://stovokor.unfoog.de/pub/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/portage"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/eix-0.5.1-bug121360.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	einfo "Please run 'update-eix' to setup the portage search database."
	einfo "The database file will be located at /var/cache/eix"
	echo
	einfo "If you want to use cdb support, you need to add"
	einfo "    PORTDIR_CACHE_METHOD=\"cdb\""
	einfo "to /etc/eixrc or ~/.eixrc"
	echo
	einfo "If you want to use the backported cache patch of portage-2.1"
	einfo "you need to add"
	einfo "    PORTDIR_CACHE_METHOD=\"backport\""
	einfo "to /etc/eixrc or ~/.eixrc"
}
