# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.7.1-r3.ebuild,v 1.2 2003/10/17 08:39:29 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
# http://gnocatan.sourceforge.net/ is terribly outdated
HOMEPAGE="http://www.sourceforge.net/projects/gnocatan/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1*
	=dev-libs/glib-1*
	gnome-base/gnome-libs
	gnome-base/ORBit"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s/term1.dccs.com.au/gnocatan.debian.net/" ${S}/common/meta.h || \
			die "sed meta.h failed"
	epatch ${FILESDIR}/gnocatan-wijnen-patch.diff
}

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	exeinto /etc/init.d
	doexe ${FILESDIR}/gnocatan
	dodoc AUTHORS ChangeLog README
}
