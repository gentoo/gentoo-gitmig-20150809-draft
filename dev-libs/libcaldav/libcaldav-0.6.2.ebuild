# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcaldav/libcaldav-0.6.2.ebuild,v 1.2 2011/07/18 09:38:00 dilfridge Exp $

EAPI=3

inherit base

DESCRIPTION="C library implementing client support for CalDAV"
HOMEPAGE="http://libcaldav.sourceforge.net/"
SRC_URI="mirror://sourceforge/libcaldav/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-libs/glib
	net-misc/curl[ssl,gnutls]
"
DEPEND="${RDEPEND}
	doc? ( 	app-doc/doxygen
		virtual/latex-base )
"

src_configure() {
	econf $(use_enable doc) || die
}
