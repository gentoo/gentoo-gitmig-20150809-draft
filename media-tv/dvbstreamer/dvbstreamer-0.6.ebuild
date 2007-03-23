# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/dvbstreamer/dvbstreamer-0.6.ebuild,v 1.2 2007/03/23 15:20:49 zzam Exp $

inherit multilib

DESCRIPTION="DVB over UDP streaming solution"
HOMEPAGE="http://dvbstreamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-libs/libdvbpsi-0.1.5
	>=dev-db/sqlite-3
	sys-libs/readline"

DEPEND="${RDEPEND}
	media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}
	# delete unneeded linking against libtermcap
	sed -i ${S}/src/Makefile* -e 's:-ltermcap::'
}

src_compile() {
	econf --libdir=/usr/$(get_libdir) || "configure failed"
	emake || "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	rm -rf ${D}/usr/doc/DVBStreamer/

	dodoc doc/*.txt ChangeLog README AUTHORS NEWS TODO || die "dodoc failed"
}

