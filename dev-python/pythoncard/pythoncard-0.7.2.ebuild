# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.7.2.ebuild,v 1.2 2004/04/01 23:04:30 kloeri Exp $

inherit distutils

DESCRIPTION="Cross-platform GUI construction kit for python"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/pythoncard/PythonCardPrototype-${PV}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">=dev-python/wxPython-2.4.1.2"

S=${WORKDIR}/PythonCardPrototype-${PV}

mydoc="README.txt README_StyleEditor.txt"
