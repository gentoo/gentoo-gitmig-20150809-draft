# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aylet/aylet-0.3.ebuild,v 1.2 2004/04/04 09:43:47 dholm Exp $

DESCRIPTION="Aylet plays music files in the .ay format"
HOMEPAGE="http://rus.members.beeb.net/aylet.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/apps/sound/players/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk"

DEPEND="sys-libs/ncurses
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	emake CFLAGS="${CFLAGS} -DDRIVER_OSS" aylet || die
	use gtk && emake CFLAGS="${CFLAGS} -DDRIVER_OSS" xaylet || die
}

src_install() {
	## binary files
	dobin aylet
	use gtk && dobin xaylet

	## doc and man
	dodoc ChangeLog NEWS README TODO
	doman aylet.1
	use gtk && dosym aylet.1.gz /usr/share/man/man1/xaylet.1.gz
}
