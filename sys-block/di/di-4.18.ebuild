# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-4.18.ebuild,v 1.7 2012/05/06 16:25:13 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND=""

src_compile() {
	tc-export CC
	# execute it _with bash_; setting SHELL=/bin/bash ${SHELL} won't
	# work because the command is interpreted _before_ the SHELL is
	# set. And this does not work properly as a standard sh script.
	SHELL=/bin/bash prefix="${D}" bash ./Build || die
}

src_install() {
	doman di.1
	dobin di || die
	dosym di /usr/bin/mi
	dodoc README
}
