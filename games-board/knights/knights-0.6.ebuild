# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-0.6.ebuild,v 1.8 2004/08/15 06:52:56 vapier Exp $

inherit kde
need-kde 3

THEME=${PN}-themepack-0.5.9
DESCRIPTION="KDE Chess Interface"
HOMEPAGE="http://knights.sourceforge.net/"
SRC_URI="mirror://sourceforge/knights/${P}.tar.gz
	mirror://sourceforge/knights/${THEME}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

src_compile() {
	./configure \
		--datadir="${KDEDIR}" \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	cd ../${PN}-themepack || die "Themes seem to be missing."
	insinto ${KDEDIR}/share/apps/knights/themes/
	doins *.tar.gz
}
