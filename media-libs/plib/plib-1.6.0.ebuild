# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.6.0.ebuild,v 1.15 2006/01/25 05:26:24 joshuabaergen Exp $

inherit flag-o-matic

DESCRIPTION="multimedia library used by many games"
HOMEPAGE="http://plib.sourceforge.net/"
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha hppa"
IUSE=""

DEPEND="sys-devel/autoconf"
RDEPEND="virtual/opengl
	virtual/glut"

src_compile() {
	[ "${ARCH}" = "hppa" ] && append-flags -fPIC
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
