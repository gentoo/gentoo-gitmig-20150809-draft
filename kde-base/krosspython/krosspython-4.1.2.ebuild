# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.1.2.ebuild,v 1.1 2008/10/21 23:29:11 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdebindings
KMMODULE=python/${PN}
NEED_KDE="4.1"
inherit kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-lang/python"

# Required for python/pykde4/cmake/modules/FindPythonLibrary.cmake which is
# used by krosspython
KMEXTRACTONLY="python/pykde4"
