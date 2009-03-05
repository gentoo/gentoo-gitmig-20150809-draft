# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-sword/kio-sword-0.3.ebuild,v 1.2 2009/03/05 16:05:14 mr_bones_ Exp $

inherit kde eutils toolchain-funcs flag-o-matic

DESCRIPTION="a nice kio handler to sword"
HOMEPAGE="http://lukeplant.me.uk/kio-sword/"
SRC_URI="mirror://sourceforge/kio-sword/kio_sword-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=app-text/sword-1.5.8"

S="${WORKDIR}/kio_sword-${PV}"
need-kde 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/kio_sword-build_fixes.patch
}

pkg_postinst() {
	elog "It is recommended that you have modules installed for sword."
	elog "Gentoo provides the \"sword-modules\" package for convenience:"
	elog "\temerge sword-modules"
}
