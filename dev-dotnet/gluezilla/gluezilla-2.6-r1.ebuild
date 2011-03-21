# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gluezilla/gluezilla-2.6-r1.ebuild,v 1.5 2011/03/21 20:22:21 ranger Exp $

EAPI=2

inherit go-mono mono autotools

DESCRIPTION="A simple library to embed Gecko (xulrunner) in the Mono Winforms WebControl"
HOMEPAGE="http://mono-project.com/Gluezilla"

LICENSE="LGPL-2 MPL-1.1"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

RDEPEND="net-libs/xulrunner:1.9
	x11-libs/gtk+:2
	>=dev-lang/mono-${PV}
	"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-xulrunner-detection.patch" || die "Failed to patch"
	eautoreconf
}
