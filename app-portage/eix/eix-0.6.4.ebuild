# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.6.4.ebuild,v 1.1 2006/08/17 21:05:23 genstef Exp $

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://dev.croup.de/proj/eix"
SRC_URI="mirror://sourceforge/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog TODO
}

pkg_postinst() {
	einfo "As of >=eix-0.5.4, \"metadata\" is the new default cache."
	einfo "It's independent of the portage-version and the cache used by portage."
}
