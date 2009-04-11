# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.2.2.ebuild,v 1.1 2009/04/11 23:53:40 alexxy Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="python/krosspython"
inherit kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/python
"
RDEPEND="${DEPEND}"
