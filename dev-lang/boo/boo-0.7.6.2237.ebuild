# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.7.6.2237.ebuild,v 1.1 2006/10/29 16:56:27 latexer Exp $

inherit mono fdo-mime eutils

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"

SRC_URI="http://dist.codehaus.org/boo/distributions/${P}-src.tar.bz2"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.4
		dev-dotnet/nant
		x11-misc/shared-mime-info
		>=x11-libs/gtksourceview-1.0.1"

src_compile() {
	LC_ALL="C" LANG="C" nant -t:mono-2.0 -D:install.prefix=/usr || die
}

src_install() {
	LC_ALL="C" LANG="C" nant install \
		-D:install.destdir=${D} -t:mono-2.0 -D:install.prefix=/usr || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
