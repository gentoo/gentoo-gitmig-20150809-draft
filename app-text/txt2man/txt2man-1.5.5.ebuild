# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2man/txt2man-1.5.5.ebuild,v 1.5 2010/10/24 15:41:57 ranger Exp $

DESCRIPTION="txt2man, src2man (C only) and bookman convert scripts for man pages."
HOMEPAGE="http://mvertes.free.fr/"
SRC_URI="http://mvertes.free.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE=""

DEPEND="app-shells/bash
	sys-apps/gawk"

src_compile() { :; }

src_install() {
	dobin bookman src2man txt2man || die "dobin failed."
	doman *.1
	dodoc Changelog README
}
