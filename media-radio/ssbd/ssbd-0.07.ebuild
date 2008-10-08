# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ssbd/ssbd-0.07.ebuild,v 1.3 2008/10/08 09:49:46 flameeyes Exp $

DESCRIPTION="SSB Voice Keyer Daemon for tucnak"
HOMEPAGE="http://tucnak.nagano.cz/tucnak1en.html"
SRC_URI="http://tucnak.nagano.cz/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	media-libs/libsndfile
	=dev-libs/glib-1.2*"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
