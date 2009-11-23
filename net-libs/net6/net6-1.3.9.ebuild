# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/net6/net6-1.3.9.ebuild,v 1.5 2009/11/23 14:41:53 maekke Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Network access framework for IPv4/IPv6 written in C++"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="nls"

RDEPEND="dev-libs/libsigc++:2
	>=net-libs/gnutls-1.2.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20
	nls? ( sys-devel/gettext )"

src_prepare() {
	#bug #271989
	epatch "${FILESDIR}"/net6-1.3.9-libgnutls.patch
	#bug #271994
	sed -i -e 's:@addcflags@::g' net6-1.3.pc.in || die
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
