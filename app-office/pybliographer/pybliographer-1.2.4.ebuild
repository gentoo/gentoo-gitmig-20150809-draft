# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/pybliographer/pybliographer-1.2.4.ebuild,v 1.2 2004/10/21 03:19:32 usata Exp $

inherit gnome2

DESCRIPTION="Pybliographer is a tool for working with bibliographic databases"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

# gnome2.eclass
USE_DESTDIR=1
DOCS="AUTHORS COPYING ChangeLog* INSTALL NEWS TODO README"

DEPEND="virtual/python
	>=dev-libs/glib-2
	>=app-text/recode-3.6-r1
	>=dev-python/gnome-python-2
	>=dev-python/python-bibtex-1.2.1"
