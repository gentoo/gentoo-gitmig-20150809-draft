# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs2svn/cvs2svn-1.1.0.ebuild,v 1.1 2004/11/05 21:12:36 agriffis Exp $

inherit distutils

DESCRIPTION="convert a CVS repository to a Subversion repository"
HOMEPAGE="http://cvs2svn.tigris.org/"
SRC_URI="http://cvs2svn.tigris.org/files/documents/1462/16792/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~ia64"
IUSE=""

DEPEND="dev-lang/python"
