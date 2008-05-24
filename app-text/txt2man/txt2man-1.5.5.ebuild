# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2man/txt2man-1.5.5.ebuild,v 1.1 2008/05/24 08:56:25 drac Exp $

DESCRIPTION="A simple script to convert ASCII text to man page."
HOMEPAGE="http://mvertes.free.fr/"
SRC_URI="http://mvertes.free.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-apps/gawk"

src_compile() { :; }

src_install() {
	dobin bookman src2man txt2man || die "dobin failed."
	doman *.1
	dodoc Changelog README
}
