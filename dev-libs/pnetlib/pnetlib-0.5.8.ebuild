# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pnetlib/pnetlib-0.5.8.ebuild,v 1.5 2003/07/02 16:55:07 scandium Exp $

inherit eutils libtool

DESCRIPTION="Portable .NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="X"

DEPEND="=dev-lang/pnet-${PV}*
	X? ( virtual/x11 )"

src_unpack() {
# Small patch to fix compilation on systems without X11

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Xsharp.patch
	epatch ${FILESDIR}/configure-X11.patch
	elibtoolize
	./auto_gen.sh || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
