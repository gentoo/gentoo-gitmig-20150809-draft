# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-0.5.ebuild,v 1.4 2004/03/12 08:51:22 mr_bones_ Exp $

inherit eutils

IUSE=""

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-libs/libtermcap-compat
	sys-apps/diffutils
	sys-apps/less"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
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

	if [ -z "`use build`" ]
	then
		dodoc COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/info
	fi
}
