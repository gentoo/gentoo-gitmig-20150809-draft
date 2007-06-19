# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.2.57.1.ebuild,v 1.4 2007/06/19 18:08:36 wolf31o2 Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Red Hat Hardware detection tools"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"
SRC_URI="mirror://gentoo/kudzu-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 -mips ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND="dev-libs/popt
	>=sys-apps/pciutils-2.2.4"
RDEPEND="${DEPEND}
	sys-apps/hwdata-gentoo
	!sys-apps/kudzu"

S=${WORKDIR}/kudzu-${PV}

src_unpack() {
	unpack ${A}

	epatch \
		"${FILESDIR}"/kudzu-${PV}-sbusfix.patch \
		"${FILESDIR}"/kudzu-${PV}-sparc-keyboard.patch
}


src_compile() {
	append-ldflags -lz
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	if [ $(tc-arch-kernel) == "powerpc" ]; then
		emake libkudzu.a libkudzu_loader.a ARCH="ppc" \
			RPM_OPT_FLAGS="${CFLAGS}" || die
	else
		emake libkudzu.a libkudzu_loader.a ARCH=$(tc-arch-kernel) \
			RPM_OPT_FLAGS="${CFLAGS}" || die
	fi
}

src_install() {
	keepdir /etc/sysconfig
	insinto /usr/include/kudzu
	doins *.h
	dolib.a libkudzu.a libkudzu_loader.a
}
