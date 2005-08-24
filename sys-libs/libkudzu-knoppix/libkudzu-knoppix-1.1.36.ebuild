# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu-knoppix/libkudzu-knoppix-1.1.36.ebuild,v 1.1 2005/08/24 14:13:47 wolf31o2 Exp $

inherit eutils

MY_PV=${PV}-2
S=${WORKDIR}/kudzu-${PV}
DESCRIPTION="Knoppix version of the Red Hat hardware detection tools"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/kudzu-knoppix_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/popt
		sys-apps/hwdata-knoppix"
DEPEND="${RDEPEND}
	sys-apps/pciutils
	!sys-libs/libkudzu
	!sys-apps/kudzu
	!sys-apps/kudzu-knoppix"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/sunlance.patch
}

src_compile() {
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	emake libkudzu.a RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /etc/sysconfig
	insinto /usr/include/kudzu
	doins *.h
	dolib.a libkudzu.a
}
