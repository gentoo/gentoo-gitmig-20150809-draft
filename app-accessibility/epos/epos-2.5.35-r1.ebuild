# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/epos/epos-2.5.35-r1.ebuild,v 1.4 2005/07/24 22:44:03 eradicator Exp $

IUSE="portaudio"

inherit eutils

DESCRIPTION="language independent text-to-speech system"
HOMEPAGE="http://epos.ure.cas.cz/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="portaudio? ( =media-libs/pablio-18*
	              >=media-libs/portaudio-18.1-r3
	              <media-libs/portaudio-19_alpha1 )"
DEPEND=">=app-text/sgmltools-lite-3.0.3-r9
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
	doexe ${FILESDIR}/eposd

	dodoc WELCOME THANKS Changes ${FILESDIR}/README.gentoo
}
