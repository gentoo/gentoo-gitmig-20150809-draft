# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/kphone/kphone-4.1.0.ebuild,v 1.1 2009/04/28 15:54:37 volkmar Exp $

inherit eutils kde

DESCRIPTION="A SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
HOMEPAGE="http://www.wirlab.net/kphone/index.html"
SRC_URI="http://www.wirlab.net/kphone/${P}.tar.gz"

KEYWORDS="x86 ~amd64 sparc ~ppc"
LICENSE="GPL-2"

IUSE="alsa jack"
SLOT="0"

S=${WORKDIR}/kphone

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}"

need-kde 3

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefiles.patch
}

src_compile(){
	# Fix for our kde location
	myconf="$myconf --with-extra-libs=$KDEDIR/lib --prefix=/usr `use_enable alsa` `use_enable jack`"
	econf ${myconf} || die "econf failed"
	emake
}
