# Copyright 1999-2004 Gentoo Foundation, Pieter Van den Abeele <pvdabeel@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-8.1.ebuild,v 1.2 2004/07/12 08:44:05 mr_bones_ Exp $

DESCRIPTION="Darwin ncurses, console display library"

HOMEPAGE="http://www.opensource.apple.com/darwinsource/"
SRC_URI=""
LICENSE="APSL-2"
SLOT="0"
KEYWORDS="-* macos"
IUSE=""
PROVIDE=""

# I haven't listed any deps here, we're currently not building Darwin from scratch yet.
# For now, this is a dummy package provided upstream. The version provided by the
# distributor is pinpointed in the users profile

DEPEND=""
RDEPEND=""

src_unpack() {
	# Portage can't do nothing
	mkdir -p ${S}
}

src_compile() {
	# This is not an empty function
	sleep 0
}

src_install() {
	# This is not an empty function
	sleep 0
}
