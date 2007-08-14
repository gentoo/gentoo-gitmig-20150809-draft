# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.1.62-r1.ebuild,v 1.19 2007/08/14 21:27:56 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="http://www.ibiblio.org/onebase/devbase/app-packs/kudzu-${PV}.tar.bz2"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips ppc ppc64 sparc x86"
IUSE="zlib"

RDEPEND="${DEPEND}
	sys-apps/hwdata-gentoo
	!sys-apps/kudzu"
DEPEND="dev-libs/popt
	zlib? ( sys-libs/zlib )
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
	if use zlib
	then
		append-ldflags -lz
	elif built_with_use --missing false sys-apps/pciutils zlib
	then
		die "You need to build with USE=zlib to match sys-apps/pcituils"
	fi
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
