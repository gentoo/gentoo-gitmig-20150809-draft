# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pexpect/pexpect-0.999.ebuild,v 1.7 2005/01/09 06:19:23 cryos Exp $

inherit distutils

IUSE=""
DESCRIPTION="Pexpect is a pure Python module for spawning child applications; controlling them; and responding to expected patterns in their output"
HOMEPAGE="http://pexpect.sourceforge.net/"
SRC_URI="mirror://sourceforge/pexpect/${P}.tgz"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc ~s390 amd64 ~ppc-macos"
DEPEND="dev-lang/python"

mydoc="README.txt"
