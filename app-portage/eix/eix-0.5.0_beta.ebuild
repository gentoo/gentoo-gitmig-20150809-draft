# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.5.0_beta.ebuild,v 1.1 2005/11/07 20:04:21 hollow Exp $

inherit eutils flag-o-matic bash-completion

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://dev.croup.de/proj/eix"
SRC_URI="http://dev.gentoo.org/~hollow/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/portage"

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion contrib/eix.bash-completion "${PN}"
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

	bash-completion_pkg_postinst
}
