# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20030403.ebuild,v 1.2 2005/01/01 14:47:18 eradicator Exp $

MY_PV="2003-04-03"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Linux kernel module for HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omke"
SRC_URI="mirror://sourceforge/omke/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/kernel"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake CC="gcc ${CFLAGS}" || die
}

src_install() {
	# The driver goes into the standard modules location
	# Not the make install location, because that way it would get deleted
	# when the user did a make modules_install in the Kernel tree

	insinto /lib/modules/${KV}/char
	doins omnibook.o

	dodoc ${S}/doc/*

}

pkg_postinst() {
	echo "running depmod...."
	depmod -aq || die
}
