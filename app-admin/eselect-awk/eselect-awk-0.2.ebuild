# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-awk/eselect-awk-0.2.ebuild,v 1.2 2012/06/04 17:25:28 ago Exp $

EAPI=4

DESCRIPTION="Manages the {,/usr}/bin/awk symlink"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~ottxor/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	insinto /usr/share/eselect/modules
	doins awk.eselect
}
