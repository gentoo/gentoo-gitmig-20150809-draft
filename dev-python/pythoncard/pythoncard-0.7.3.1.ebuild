# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.7.3.1.ebuild,v 1.4 2004/06/25 01:44:12 agriffis Exp $

inherit distutils

DESCRIPTION="Cross-platform GUI construction kit for python"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/pythoncard/PythonCardPrototype-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND=">=dev-python/wxPython-2.4.2.4"

S=${WORKDIR}/PythonCardPrototype-${PV}

mydoc="README.txt README_StyleEditor.txt"

