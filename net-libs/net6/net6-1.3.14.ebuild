# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/net6/net6-1.3.14.ebuild,v 1.3 2011/11/02 14:46:24 phajdan.jr Exp $

EAPI=4

inherit multilib

DESCRIPTION="Network access framework for IPv4/IPv6 written in C++"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 hppa ~ppc x86"
IUSE="nls static-libs"

RDEPEND="dev-libs/libsigc++:2
	>=net-libs/gnutls-1.2.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf $(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || rm -f "${D}"/usr/$(get_libdir)/lib${PN}.la
}
