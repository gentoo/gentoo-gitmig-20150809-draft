# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxklavier/libxklavier-1.00.ebuild,v 1.1 2004/03/18 22:17:33 foser Exp $

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"
SRC_URI="mirror://sourceforge/gswitchit/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="virtual/x11
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {

	econf `use_enable doc doxygen` || die
	emake || die

}

src_install() {

	einstall || die

	dodoc "AUTHORS COPYING* CREDITS ChangeLog INSTALL NEWS README"

}
