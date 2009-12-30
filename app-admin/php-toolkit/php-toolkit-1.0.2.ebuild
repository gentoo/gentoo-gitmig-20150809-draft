# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/php-toolkit/php-toolkit-1.0.2.ebuild,v 1.1 2009/12/30 00:47:19 hoffie Exp $
EAPI="2"

inherit multilib

DESCRIPTION="Utilities for managing installed copies of PHP"
HOMEPAGE="http://www.gentoo.org/proj/en/php/"
SRC_URI="http://dev.gentoo.org/~hoffie/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_configure() {
	sed -i php-select -e "s:@@GENTOO_LIBDIR@@:$(get_libdir):" || \
		die "GENTOO_LIBDIR sed failed"
}

src_install() {
	# install php-select
	dosbin php-select || die

	dodir /usr/share/php-select
	insinto /usr/share/php-select
	doins php-select-modules/*

	dodoc ChangeLog TODO
}
