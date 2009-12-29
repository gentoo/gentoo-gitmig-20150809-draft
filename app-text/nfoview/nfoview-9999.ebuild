# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/nfoview/nfoview-9999.ebuild,v 1.6 2009/12/29 16:51:28 vapier Exp $

inherit distutils
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://gitorious.org/nfoview/mainline.git"
	inherit git
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="http://download.gna.org/nfoview/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="simple viewer for NFO files, which are ASCII art in the CP437 codepage"
HOMEPAGE="http://home.gna.org/nfoview/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}
	media-fonts/terminus-font"
