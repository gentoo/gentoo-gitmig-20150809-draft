# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/yasr/yasr-0.6.9.ebuild,v 1.5 2008/06/28 23:40:16 loki_val Exp $

inherit base

DESCRIPTION="general-purpose console screen reader"
HOMEPAGE="http://yasr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	econf --datadir='/etc' || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog AUTHORS BUGS CREDITS
	dosed \
	's:^\(synthesizer=emacspeak server\):#\1:
	s:^\(synthesizer port=|/usr/local/bin/eflite\):#\1:
	s:^#\(synthesizer=speech dispatcher\):\1:
	s:^#\(synthesizer port=127.0.0.1.6560\):\1:' /etc/yasr/yasr.conf
}

pkg_postinst() {
	elog
	elog "Speech-dispatcher is configured as the default synthesizer for yasr."
}
