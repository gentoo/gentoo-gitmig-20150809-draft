# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.6.2.ebuild,v 1.4 2011/06/01 18:49:43 ranger Exp $

EAPI=3

KMNAME="kdebindings"
KMMODULE="python/krosspython"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

pkg_setup() {
	python_set_active_version 2
	kde4-meta_pkg_setup
}
