# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.1.62-r1.ebuild,v 1.12 2006/08/26 04:55:47 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Red Hat Hardware detection tools"
SRC_URI="http://www.ibiblio.org/onebase/devbase/app-packs/kudzu-${PV}.tar.bz2"
HOMEPAGE="http://fedora.redhat.com/projects/additional-projects/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-libs/popt
	sys-apps/hwdata-gentoo"
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
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	emake libkudzu.a RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	keepdir /etc/sysconfig
	insinto /usr/include/kudzu
	doins *.h
	dolib.a libkudzu.a
}
