# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxklavier/libxklavier-1.00.ebuild,v 1.6 2004/04/05 19:43:58 agriffis Exp $

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"
SRC_URI="mirror://sourceforge/gswitchit/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~hppa ~alpha ~ia64"
IUSE="doc"

RDEPEND="virtual/x11
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}

	cd ${S}
	[ `use sparc` ] && epatch ${FILESDIR}/sun-keymaps.patch
}

src_compile() {

	econf `use_enable doc doxygen` || die
	emake || die

}

src_install() {

	einstall || die

	insinto /usr/share/libxklavier
	[ `use sparc` ] && doins ${FILESDIR}/sun.xml

	dodoc "AUTHORS COPYING* CREDITS ChangeLog INSTALL NEWS README"

}
