# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aylet/aylet-0.3.ebuild,v 1.7 2004/09/14 07:23:33 eradicator Exp $

DESCRIPTION="Aylet plays music files in the .ay format"
HOMEPAGE="http://rus.members.beeb.net/aylet.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/apps/sound/players/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"
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
