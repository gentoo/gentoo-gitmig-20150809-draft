# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-zeroconf/mono-zeroconf-0.8.0.ebuild,v 1.1 2008/11/24 00:13:14 loki_val Exp $

EAPI=1

inherit eutils mono

DESCRIPTION="a cross platform Zero Configuration Networking library for Mono and .NET."
HOMEPAGE="http://www.mono-project.com/Mono.Zeroconf"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+avahi"

RDEPEND=">=dev-lang/mono-1.1.10
	avahi? ( >=net-dns/avahi-0.6 )
	!avahi? ( net-misc/mDNSResponder )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	local fail="Re-emerge net-dns/avahi with USE mono."
	if use avahi && ! built_with_use net-dns/avahi mono; then
		eerror "${fail}"
		die "${fail}"
	fi
}

src_compile() {
	local myconf
	use avahi || myconf="--disable-avahi"
	use avahi && myconf="--disable-mdnsresponder"
	econf --disable-docs ${myconf}
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
