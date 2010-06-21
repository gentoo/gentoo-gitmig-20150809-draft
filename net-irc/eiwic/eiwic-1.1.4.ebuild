# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/eiwic/eiwic-1.1.4.ebuild,v 1.2 2010/06/21 17:04:35 angelos Exp $

inherit autotools eutils multilib flag-o-matic

DESCRIPTION="A modular IRC bot written in C"
HOMEPAGE="http://lordi.styleliga.org/eiwic/"
SRC_URI="http://lordi.styleliga.org/eiwic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc ipv6 rss"

DEPEND="rss? ( media-libs/raptor )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "/^set MODULE_PATH/s:modules:/usr/$(get_libdir)/eiwic:" sample.conf
	sed -i "/^load MODULE/s:$:.so:" sample.conf
	epatch "${FILESDIR}"/${PN}-1.1.3-ldflags.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug vv-debug) \
		$(use_enable ipv6)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO sample.conf

	if use doc; then
		dohtml doc/*
	fi
}

pkg_postinst() {
	echo
	einfo "You need a configuration file to run eiwic"
	einfo "A sample configuration was installed to"
	einfo "/usr/share/doc/${PF}/"
	echo
	if use debug; then
		einfo "For debugging options please see eiwic -h"
		echo
	fi
}
