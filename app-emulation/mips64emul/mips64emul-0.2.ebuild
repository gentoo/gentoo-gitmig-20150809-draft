# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mips64emul/mips64emul-0.2.ebuild,v 1.1 2004/09/11 05:14:53 kumba Exp $

DESCRIPTION="MIPS Machine Emulator, Emulates many machines/CPUs/OSes"
HOMEPAGE="http://www.mdstud.chalmers.se/~md1gavan/${PN}/index.html"
SRC_URI="http://www.mdstud.chalmers.se/~md1gavan/${PN}/src/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ~mips"
IUSE="X cacheemu delays mips16"
#IUSE="X cacheemu delays mips16 userland"
DEPEND="X? ( virtual/x11 )"
RDEPEND=""


src_compile() {
	cd ${S}

	# See what configure options to pass
	local myconf
	use ! X && myconf="${myconf} --nox11"
	use cacheemu && myconf="${myconf} --caches"
	use delays && myconf="${myconf} --delays"
	use mips16 && myconf="${myconf} --mips16"
#	use userland && myconf="${myconf} --userland"	# Not implemented yet, in 0.3

	# Run configure
	einfo "Passing the following flags to configure: ${myconf}"
	echo -e ""
	./configure ${myconf}
	echo -e ""

	# Build
	emake
}

src_install() {
	cd ${S}
	dodoc BUGS HISTORY LICENSE README RELEASE TODO doc/index.html doc/technical.html
	doman doc/mips64emul.1
	dobin mips64emul
}
