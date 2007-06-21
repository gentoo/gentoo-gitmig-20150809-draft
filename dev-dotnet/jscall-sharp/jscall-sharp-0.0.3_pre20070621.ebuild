# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/jscall-sharp/jscall-sharp-0.0.3_pre20070621.ebuild,v 1.1 2007/06/21 22:50:08 jurek Exp $

inherit mono eutils

DESCRIPTION="A simple JavaScript bridge for Gecko#"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( www-client/mozilla-firefox
			www-client/seamonkey )
		>=dev-lang/mono-1.1.9
		>=dev-dotnet/gtk-sharp-2.4
		>=dev-dotnet/gecko-sharp-0.10"

src_unpack()
{
	unpack ${A}
	cd ${S}

	einfo "Running autogen..."
	./autogen.sh || die "autogen failed"
}

src_install()
{
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) \
		/gacdir /usr/$(get_libdir) /package ${PN}-0.0.3" \
		DESTDIR=${D} install || die

	dodoc ChangeLog README COPYING AUTHORS
}
