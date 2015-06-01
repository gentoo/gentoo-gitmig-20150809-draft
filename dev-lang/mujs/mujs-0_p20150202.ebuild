# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mujs/mujs-0_p20150202.ebuild,v 1.1 2015/06/01 12:05:28 xmw Exp $

EAPI=5

inherit eutils toolchain-funcs vcs-snapshot

DESCRIPTION="lightweight Javascript interpreter"
HOMEPAGE="http://mujs.com/"
SRC_URI="http://git.ghostscript.com/?p=mujs.git;a=snapshot;h=c1ad1ba1e482e7d01743e3f4f9517572bebf99ac;sf=tgz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
	tc-export CC
}
