# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.7.ebuild,v 1.1 2003/04/20 01:59:03 blauwers Exp $

inherit distutils

DESCRIPTION="Cross-platform GUI construction kit for python"
SRC_URI="mirror://sourceforge/pythoncard/PythonCardPrototype-${PV}.tar.gz"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
LICENSE="PYTHON"

DEPEND=">=dev-python/wxPython-2.3.2.1-r2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S=${WORKDIR}/PythonCardPrototype-${PV}

mydoc="README.txt README_StyleEditor.txt"
