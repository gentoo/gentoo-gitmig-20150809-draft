# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kphone/kphone-4.1.1.ebuild,v 1.2 2005/08/24 08:39:43 greg_g Exp $

inherit eutils kde-functions

DESCRIPTION="A SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
HOMEPAGE="http://www.wirlab.net/kphone/index.html"
SRC_URI="http://www.wirlab.net/kphone/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="alsa debug jack"

S=${WORKDIR}/${PN}

DEPEND="dev-libs/openssl
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"

need-qt 3

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix compilation with gcc-3.4. Applied in CVS.
	epatch "${FILESDIR}/${P}-gcc34.patch"
}


src_compile() {
	local myconf="$(use_enable alsa) $(use_enable jack)
	              $(use_enable debug)"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES README
}
