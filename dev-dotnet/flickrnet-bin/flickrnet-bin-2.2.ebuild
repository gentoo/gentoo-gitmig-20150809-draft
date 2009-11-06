# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/flickrnet-bin/flickrnet-bin-2.2.ebuild,v 1.3 2009/11/06 16:34:05 volkmar Exp $

EAPI=2

MY_PN="FlickrNet"

inherit mono

DESCRIPTION="A .Net Library for accessing the Flickr API - Binary version"
HOMEPAGE="http://www.codeplex.com/FlickrNet"

# Upstream download require click-through LGPL-2.1.
# Since the license allows us to do that, just redistribute
# it in a decent format.
SRC_URI="mirror://gentoo/${MY_PN}${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_compile() {
	:
}

src_install() {
	egacinstall Release/${MY_PN}.dll ${MY_PN} || die
}
