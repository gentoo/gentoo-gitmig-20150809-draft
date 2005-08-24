# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.1.62.ebuild,v 1.4 2005/08/24 14:18:10 wolf31o2 Exp $

inherit eutils

S=${WORKDIR}/kudzu-${PV}
DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="http://www.ibiblio.org/onebase/devbase/app-packs/kudzu-${PV}.tar.bz2"
HOMEPAGE="http://fedora.redhat.com/projects/additional-projects/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips -ppc -ppc64 sparc x86"
IUSE=""

RDEPEND="dev-libs/popt
	|| (
		sys-apps/hwdata-knoppix
		sys-apps/hwdata )"
DEPEND="dev-libs/popt
	sys-apps/pciutils
	!sys-apps/kudzu
	!sys-apps/kudzu-knoppix
	!sys-libs/libkudzu-knoppix"

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
