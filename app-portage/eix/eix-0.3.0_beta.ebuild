# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.3.0_beta.ebuild,v 1.1 2005/08/16 08:08:41 hollow Exp $

inherit eutils flag-o-matic bash-completion

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://eixwiki.unfoog.de"
SRC_URI="mirror://sourceforge/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/portage"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion contrib/eix.bash-completion "${PN}"
}

pkg_postinst() {
	einfo "Please run 'update-eix' to setup the portage search database."
	einfo "The database file will be located at /var/cache/eix"
	echo
	einfo "If you want to use the cdb-support, you need to add"
	einfo "    PORTDIR_CACHE_METHOD=\"cdb\""
	einfo "to you /etc/eixrc or ~/.eixrc"

	bash-completion_pkg_postinst
}
