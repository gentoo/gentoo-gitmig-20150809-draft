# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/euler/euler-1.61.0.ebuild,v 1.1 2006/01/18 08:14:16 spyderous Exp $

DESCRIPTION="Mathematical programming environment"
HOMEPAGE="http://euler.sourceforge.net/"
SRC_URI="mirror://sourceforge/euler/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc ~amd64"
IUSE=""
DEPEND=">=x11-libs/gtk+-2"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
