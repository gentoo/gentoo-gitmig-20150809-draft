# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.6.0.ebuild,v 1.10 2004/01/25 07:39:56 vapier Exp $

inherit flag-o-matic

DESCRIPTION="multimedia library used by many games"
HOMEPAGE="http://plib.sourceforge.net/"
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64 alpha hppa"

DEPEND="sys-devel/autoconf"
RDEPEND="virtual/x11
	virtual/glut"

src_compile() {
	[ "${ARCH}" = "hppa" ] && append-flags -fPIC
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
