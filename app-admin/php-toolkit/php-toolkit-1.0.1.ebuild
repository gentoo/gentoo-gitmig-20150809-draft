# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/php-toolkit/php-toolkit-1.0.1.ebuild,v 1.8 2008/04/14 01:31:52 vapier Exp $

DESCRIPTION="Utilities for managing installed copies of PHP"
HOMEPAGE="http://www.gentoo.org/proj/en/php/"
SRC_URI="http://gentoo.longitekk.com/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_install() {
	# install php-select
	dosbin php-select || die

	dodir /usr/share/php-select
	insinto /usr/share/php-select
	doins php-select-modules/*
}
