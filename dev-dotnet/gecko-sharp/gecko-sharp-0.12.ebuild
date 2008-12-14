# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.12.ebuild,v 1.3 2008/12/14 15:18:41 loki_val Exp $

inherit mono multilib

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-2.4.0
		||	(
				=www-client/seamonkey-1*
				=www-client/mozilla-firefox-2*
			)"
DEPEND="${RDEPEND}
		doc? ( >=virtual/monodoc-1.0 )
		>=dev-util/pkgconfig-0.19"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [[ $(get_libdir) != "lib" ]] ; then
		sed -i -e 's:^libdir.*:libdir=@libdir@:' \
			-e 's:${prefix}/lib:${libdir}:'      \
			-e 's:$(prefix)/lib:$(libdir):'      \
			${S}/Makefile.{in,am} ${S}/*.pc.in   \
		|| die
	fi
}

src_compile() {
	export GACUTIL_FLAGS="-root ${D}/usr/$(get_libdir) -gacdir /usr/$(get_libdir) -package ${PN}-${SLOT}"

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
