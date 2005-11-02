# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/db4o/db4o-4.6.ebuild,v 1.1 2005/11/02 09:02:02 latexer Exp $

inherit mono multilib

DESCRIPTION="Object database for .NET"
HOMEPAGE="http://www.db4o.com/"
SRC_URI="http://www.db4o.com/downloads/${P}-mono.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/mono"

src_compile() {
	emake -j1 buildcore || die "emake failed"
}

src_install() {
	dohtml -a html,gif,js,css -r ${S}/doc/api

	# For now we don't install into the GAC, following upstream's RPM packaging.
	insinto /usr/$(get_libdir)/db4o
	doins ${S}/bin/db4o.dll*
}
