# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libmuscle/libmuscle-3.7.ebuild,v 1.2 2009/04/21 12:28:50 weaver Exp $

EAPI="2"

MY_TAG="mauve-2-2-0-release"
#ESVN_REPO_URI="https://mauve.svn.sourceforge.net/svnroot/mauve/muscle/tags/${MY_TAG}"

#inherit subversion autotools
inherit autotools

DESCRIPTION="Library for sci-biology/mauve"
HOMEPAGE="http://gel.ahabs.wisc.edu/mauve/"
#SRC_URI=""
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

DEPEND="doc? ( app-doc/doxygen )
	!sci-biology/muscle"
RDEPEND=""

#S="${WORKDIR}"

src_prepare() {
	eautoreconf
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
