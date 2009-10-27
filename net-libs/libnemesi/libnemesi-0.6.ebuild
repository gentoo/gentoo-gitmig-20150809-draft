# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnemesi/libnemesi-0.6.ebuild,v 1.1 2009/10/27 12:45:51 ssuominen Exp $

EAPI=2
inherit autotools multilib

DESCRIPTION="a RTSP/RTP client library"
HOMEPAGE="http://lscube.org/projects/libnemesi/"
SRC_URI="http://cgit.lscube.org/cgit.cgi/${PN}/snapshot/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples ipv6 +sctp"

DEPEND=">=net-libs/netembryo-0.0.9[sctp?]"

src_prepare() {
	sed -i \
		-e 's:libnetembryo =:libnetembryo >=:' configure.ac || die
	sed -i \
		-e 's:<netembryo/rtsp_errors.h>:"rtsp_errors.h":' include/rtsp.h || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable ipv6) \
		$(use_enable sctp) \
		$(use_enable examples) \
		--disable-static \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog CodingStyle README TODO
	find "${D}"usr/$(get_libdir) -name '*.la' -delete
}
