# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/yasr/yasr-0.6.9-r1.ebuild,v 1.1 2009/02/06 15:23:16 williamh Exp $

inherit autotools eutils

DESCRIPTION="general-purpose console screen reader"
HOMEPAGE="http://yasr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

	src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-remove-m4.patch"
	rm -r "${S}/m4"
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --datadir=/etc \
	$(use_enable nls) || die "econf failed"
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
	elog "If this is not what you want, edit /etc/yasr/yasr.conf."
}
