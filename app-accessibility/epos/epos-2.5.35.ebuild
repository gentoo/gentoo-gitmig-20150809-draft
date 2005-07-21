# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/epos/epos-2.5.35.ebuild,v 1.1 2005/07/21 07:15:25 eradicator Exp $

IUSE="portaudio"

inherit eutils

DESCRIPTION="language independent text-to-speech system"
HOMEPAGE="http://epos.ure.cas.cz/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

RDEPEND="portaudio? ( >=media-libs/portaudio-18.1-r1 )"
DEPEND="app-text/sgmltools-lite
	>=sys-devel/autoconf-2.57
	=sys-devel/automake-1.7*
	sys-devel/libtool
	${RDEPEND}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-destdir.patch
	epatch ${FILESDIR}/${P}-sysportaudio.patch

	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	libtoolize --force --copy || die
	aclocal || die
	automake -a -f -c || die
	autoheader || die
	autoconf || die
}

src_compile() {
	econf $(use_enable portaudio) --enable-charsets
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	mv ${D}/usr/bin/say ${D}/usr/bin/epos_say

	exeinto /etc/init.d
	doexe ${FILESDIR}/epos

	dodoc WELCOME THANKS Changes ${FILESDIR}/README.gentoo
}
