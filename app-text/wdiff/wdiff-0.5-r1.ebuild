# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-0.5-r1.ebuild,v 1.3 2004/09/03 00:31:28 dholm Exp $

inherit eutils

IUSE="build"

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips ~ppc"

DEPEND="sys-libs/libtermcap-compat
	sys-apps/diffutils
	sys-apps/less"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-segfault-fix.diff
}

src_compile() {
	# Cannot use econf here because the configure script that
	# comes with wdiff is too old to understand the standard
	# options.

	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	einstall || die

	if ! use build
	then
		dodoc COPYING ChangeLog NEWS README
		doman wdiff.1
	else
		rm -rf ${D}/usr/share/info
	fi
}
