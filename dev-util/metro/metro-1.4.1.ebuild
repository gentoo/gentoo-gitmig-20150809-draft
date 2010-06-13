# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/metro/metro-1.4.1.ebuild,v 1.3 2010/06/13 15:01:31 armin76 Exp $

EAPI="2"

DESCRIPTION="release metatool used for creating Gentoo and Funtoo releases"
HOMEPAGE="http://www.github.com/funtoo/metro"
SRC_URI="http://www.funtoo.org/metro/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+ccache +git threads"

DEPEND=""
RDEPEND="dev-lang/python
	threads? ( app-arch/pbzip2 )
	ccache? ( dev-util/ccache )
	git? ( dev-vcs/git )"

src_install() {
	insinto /usr/lib/metro
	doins -r .
	fperms 0755 /usr/lib/metro/metro
	dosym /usr/lib/metro/metro /usr/bin/metro
}
