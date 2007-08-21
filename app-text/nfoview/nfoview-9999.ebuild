# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/nfoview/nfoview-9999.ebuild,v 1.1 2007/08/21 21:41:30 vapier Exp $

ESVN_REPO_URI="svn://svn.gna.org/svn/nfoview/trunk"
inherit distutils subversion

DESCRIPTION="simple viewer for NFO files, which are ASCII art in the CP437 codepage"
HOMEPAGE="http://home.gna.org/nfoview/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

DOCS="AUTHORS"
