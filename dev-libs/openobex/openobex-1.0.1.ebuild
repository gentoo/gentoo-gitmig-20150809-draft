# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.0.1.ebuild,v 1.15 2005/04/04 03:15:10 tgall Exp $

inherit eutils gnuconfig

IUSE=""

RESTRICT="nostrip"	# .a and .la can't be stripped, stripping
			# the .so results in library w/o symbols :-/
			# Danny van Dyk <kugelfang@gentoo.org> 2004/07/03

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ~sparc ppc -amd64 ~ppc64"

DEPEND=">=dev-libs/glib-1.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-shared-object.patch
	gnuconfig_update
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS NEWS ChangeLog
}
