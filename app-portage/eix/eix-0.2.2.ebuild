# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.2.2.ebuild,v 1.11 2005/07/09 02:38:36 swegener Exp $

inherit eutils flag-o-matic bash-completion

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://eixwiki.unfoog.de"
SRC_URI="mirror://sourceforge/eix/${P}.tar.bz2 http://frexx.de/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="sys-apps/portage"

src_compile() {
	epatch "${FILESDIR}"/0.2.2-incorrect-masks.patch
	epatch "${FILESDIR}"/0.2.2-unistd.h.patch

	aclocal || die "aclocal"
	libtoolize --force --copy || die "libtoolize"
	autoconf || die "autoconf"

	econf || die "configure failed"
	emake || die "emake	failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion contrib/eix.bash-completion ${PN}
}

pkg_postinst() {
	einfo "Please run 'update-eix' to setup the portage search database."
	einfo "The database file will be located at /var/cache/eix"
	bash-completion_pkg_postinst
}
