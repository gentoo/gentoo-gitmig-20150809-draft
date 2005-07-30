# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-gaim/festival-gaim-1.1-r1.ebuild,v 1.1 2005/07/30 15:20:12 eradicator Exp $

IUSE=""

DESCRIPTION="A plugin for gaim which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://festival-gaim.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=app-accessibility/festival-1.4.3-r4
	 >=net-im/gaim-1"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.50
	sys-devel/libtool"

src_unpack() {
	unpack ${A}

	cd ${S}
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	libtoolize --copy --force || die "libtoolize failed"
	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	automake --add-missing --copy || die "automake failed"
	autoconf || die "autoconf failed"

	sed -i -e 's:/usr/lib/festival/voices:/usr/share/festival/voices:g' ${S}/src/festival.c
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README ChangeLog
}
