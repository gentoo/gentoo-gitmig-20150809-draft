# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpdscribble/mpdscribble-0.13.ebuild,v 1.1 2008/12/20 14:55:13 angelos Exp $

EAPI=1

DESCRIPTION="An MPD client that submits information to audioscrobbler."
HOMEPAGE="http://www.frob.nl/scribble.html"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	net-libs/libsoup:2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}/mpdscribble.rc" mpdscribble
	dodoc AUTHORS NEWS README
	rm -r -f "${D}"/usr/share/doc/${PN}
	dodir /var/cache/mpdscribble
}

pkg_postinst() {
	elog "If you are going to use the init script shipped with this script, you"
	elog "will have to create a config file (/etc/${PN}.conf), see the man page"
	elog "for instructions on how to write one."
}
