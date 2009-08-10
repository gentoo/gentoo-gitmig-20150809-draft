# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/dvbstreamer/dvbstreamer-1.1.ebuild,v 1.4 2009/08/10 07:53:09 ssuominen Exp $

EAPI=2
inherit autotools eutils multilib

DESCRIPTION="DVB over UDP streaming solution"
HOMEPAGE="http://dvbstreamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	sys-libs/readline"
DEPEND="${RDEPEND}
	media-tv/linuxtv-dvb-headers"

src_prepare() {
	# delete unneeded linking against libtermcap
	sed -i -e 's:-ltermcap::' src/Makefile.am || die "sed failed"
	epatch "${FILESDIR}"/${P}-Werror.patch
	AT_NO_RECURSIVE="yes" eautoreconf
}

src_configure() {
	econf \
		--libdir=/usr/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"/usr/doc/

	dodoc doc/*.txt ChangeLog README AUTHORS NEWS TODO
}
