# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gccxml/gccxml-0.9.0_pre20120309.ebuild,v 1.1 2012/07/04 10:45:02 jlec Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="XML output extension to GCC"
HOMEPAGE="http://www.gccxml.org/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_prepare() {
	# patch below taken from Debian
	sed -i \
		-e 's/xatexit.c//' \
		"${S}/GCC/libiberty/CMakeLists.txt" || die "sed failed"
}
