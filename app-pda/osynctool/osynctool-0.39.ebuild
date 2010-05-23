# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/osynctool/osynctool-0.39.ebuild,v 1.1 2010/05/23 12:38:07 bangert Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Command line interface for OpenSync"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	!app-pda/msynctool"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's:/etc/bash_completion.d:/share/bash-completion:g' tools/CMakeLists.txt || die
}
