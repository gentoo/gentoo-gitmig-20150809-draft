# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/umix/umix-0.9.1-r1.ebuild,v 1.7 2004/03/01 05:37:16 eradicator Exp $

IUSE="ncurses gtk"

S=${WORKDIR}/${P}
DESCRIPTION="Program for adjusting soundcard volumes"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://umix.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 ppc ~alpha"
LICENSE="GPL-2"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.2 )
	gtk? ( >=x11-libs/gtk+-2.0.0 )"

src_compile() {

	local myconf

# We should never override users default -use configs
#   use ncurses || myconf="--disable-ncurses"
	use gtk     || myconf="${myconf} --disable-gtk"

	econf ${myconf} || die

	emake || die
}

src_install() {

	make DESTDIR=${D} install

	dodoc AUTHORS ChangeLog NEWS README TODO
}
