# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pexpect/pexpect-2.1.ebuild,v 1.4 2008/01/10 20:17:10 maekke Exp $

inherit distutils

DESCRIPTION="Pexpect is a pure Python module for spawning child applications; controlling them; and responding to expected patterns in their output"
HOMEPAGE="http://pexpect.sourceforge.net/"
SRC_URI="mirror://sourceforge/pexpect/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc x86"
IUSE=""

DEPEND="dev-lang/python"

DOCS="README.txt"
