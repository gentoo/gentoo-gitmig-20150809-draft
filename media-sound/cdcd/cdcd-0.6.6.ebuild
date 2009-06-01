# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.6.6.ebuild,v 1.11 2009/06/01 14:56:08 ssuominen Exp $

DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"

SLOT="0"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	>=sys-libs/readline-4.2
	>=media-libs/libcdaudio-0.99.4"
DEPEND="${RDEPEND}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
