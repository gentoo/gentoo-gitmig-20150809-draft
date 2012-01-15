# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/par2cmdline/par2cmdline-0.5.ebuild,v 1.1 2012/01/15 16:39:01 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A PAR-2.0 file verification and repair tool"
HOMEPAGE="http://parchive.sourceforge.net/ http://github.com/eMPee584/par2cmdline"
SRC_URI="mirror://github/eMPee584/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DOCS=( AUTHORS ChangeLog README )

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4-offset.patch
	eautoreconf
}
