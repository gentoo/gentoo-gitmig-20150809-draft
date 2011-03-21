# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mu/mu-0.9.2.ebuild,v 1.3 2011/03/21 23:18:35 nirbheek Exp $

EAPI=3

inherit base

DESCRIPTION="Set of tools to deal with Maildirs, in particular, searching and indexing"
HOMEPAGE="http://www.djcbsoftware.nl/code/mu/"
SRC_URI="http://mu0.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gui"

DEPEND=">=dev-libs/gmime-2.4:2.4
	dev-libs/xapian
	>=dev-libs/glib-2.22:2
	gui? ( x11-libs/gtk+:2
		net-libs/webkit-gtk:2 ) "
RDEPEND="${DEPEND}"

src_configure() {
	local guiconf
	if use gui; then
		guiconf="--with-gui=gtk2"
	else
		guiconf="--with-gui=none"
	fi

	econf "${guiconf}"
}

src_install () {
	base_src_install
	# Installing the guis is not supported by upstream
	if use gui; then
		dobin toys/mug/mug || die
		dobin toys/mug2/mug2 || die
	fi
}

DOCS=( "AUTHORS" "HACKING" "NEWS" "TODO" )
