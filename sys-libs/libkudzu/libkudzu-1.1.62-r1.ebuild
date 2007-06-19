# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.1.62-r1.ebuild,v 1.17 2007/06/19 18:08:36 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="http://www.ibiblio.org/onebase/devbase/app-packs/kudzu-${PV}.tar.bz2"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-libs/popt
	sys-apps/hwdata-gentoo
	!sys-apps/kudzu"
DEPEND="dev-libs/popt
	sys-apps/pciutils"

S=${WORKDIR}/kudzu-${PV}

src_unpack() {
	unpack ${A}
	epatch \
		"${FILESDIR}"/sunlance.patch \
		"${FILESDIR}"/ppc.patch \
		"${FILESDIR}"/typedef_byte.patch
}

src_compile() {
	append-ldflags -lz
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	if [ $(tc-arch-kernel) == "powerpc" ]; then
		emake libkudzu.a ARCH="ppc" RPM_OPT_FLAGS="${CFLAGS}" || die
	else
		emake libkudzu.a ARCH=$(tc-arch-kernel) RPM_OPT_FLAGS="${CFLAGS}" || die
	fi
}

src_install() {
	keepdir /etc/sysconfig
	insinto /usr/include/kudzu
	doins *.h
	dolib.a libkudzu.a
}
