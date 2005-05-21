# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.5.3.1544.ebuild,v 1.2 2005/05/21 09:19:01 slarti Exp $

inherit mono fdo-mime eutils

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"

SRC_URI="http://dist.codehaus.org/boo/distributions/${P}-src.tar.bz2"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.4
		dev-dotnet/nant
		x11-misc/shared-mime-info
		>=x11-libs/gtksourceview-1.0.1"


#S=${WORKDIR}

src_compile() {
	nant -D:install.prefix=/usr || die
}

src_install() {
	nant install -D:install.destdir=${D} -D:install.prefix=/usr || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
