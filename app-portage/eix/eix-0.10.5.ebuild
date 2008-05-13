# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.10.5.ebuild,v 1.10 2008/05/13 18:14:07 genstef Exp $

DESCRIPTION="Small utility for searching ebuilds with indexing for fast results"
HOMEPAGE="http://eix.sourceforge.net"
SRC_URI="mirror://sourceforge/eix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="sqlite"

DEPEND="sqlite? ( >=dev-db/sqlite-3 )
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_compile() {
	econf --with-bzip2 $(use_with sqlite) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog TODO
}

pkg_postinst() {
	elog "As of >=eix-0.5.4, \"metadata\" is the new default cache."
	elog "It's independent of the portage-version and the cache used by portage."

	elog /etc/eixrc will not get updated anymore by the eix ebuild.
	elog Upstream strongly recommends to remove this file resp. to keep
	elog only those entries which you want to differ from the defaults.
	elog Use options --dump or --dump-defaults to get an output analogous
	elog to previous /etc/eixrc files.
}
