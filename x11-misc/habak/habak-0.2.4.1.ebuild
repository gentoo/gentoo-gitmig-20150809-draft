# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/habak/habak-0.2.4.1.ebuild,v 1.1 2004/09/20 11:10:30 lucass Exp $

DESCRIPTION="A simple but powerful tool to set desktop wallpaper"
HOMEPAGE="http://lubuska.zapto.org/~hoppke/"
SRC_URI="http://fvwm-crystal.linux.net.pl/files/versions/20040919/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE=""

DEPEND="virtual/x11 virtual/xft media-libs/imlib2"

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin habak
	dodoc ChangeLog TODO COPYING README README-PL
}
