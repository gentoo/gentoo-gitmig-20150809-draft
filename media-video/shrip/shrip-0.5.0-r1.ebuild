# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/shrip/shrip-0.5.0-r1.ebuild,v 1.2 2009/07/22 21:13:32 gengor Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="Command line tool for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/glib-2.6
	=media-video/ogmrip-0.12*"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.12.0"

src_prepare() {
	# Bug #260847
	sed -i -e 's: -Werror::' configure.in || die "sed failed"

	# Bug #251367
	epatch "${FILESDIR}/${P}-wur.patch"

	eautoreconf
}

src_configure() {
	local myconf="$(use_enable debug maintainer-mode)"

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README TODO

	insinto /etc
	doins shrip.conf
}
