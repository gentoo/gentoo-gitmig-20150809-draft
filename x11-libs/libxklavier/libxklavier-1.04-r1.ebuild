# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxklavier/libxklavier-1.04-r1.ebuild,v 1.8 2005/03/24 21:30:42 hardave Exp $

inherit eutils

DESCRIPTION="High level XKB library"
HOMEPAGE="http://www.freedesktop.org/Software/LibXklavier"
SRC_URI="mirror://sourceforge/gswitchit/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="doc"

RDEPEND="virtual/x11
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_unpack() {

	unpack ${A}

	cd ${S}
	use sparc && epatch "${FILESDIR}/sun-keymaps-102.patch"

	# don't free a static var (#70633)
	epatch ${FILESDIR}/${P}-fix_free.patch

}

src_compile() {

	econf --with-xkb_base=/usr/X11R6/lib/X11/xkb \
		$(use_enable doc doxygen) || die
	emake || die "emake failed"

}

src_install() {

	einstall || die
	insinto /usr/share/libxklavier
	use sparc && doins "${FILESDIR}/sun.xml"
	dodoc AUTHORS CREDITS ChangeLog NEWS README

}
