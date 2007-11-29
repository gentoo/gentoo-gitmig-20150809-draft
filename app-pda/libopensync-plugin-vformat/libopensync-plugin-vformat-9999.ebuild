# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-vformat/libopensync-plugin-vformat-9999.ebuild,v 1.1 2007/11/29 21:42:50 peper Exp $

inherit cmake-utils subversion

DESCRIPTION="OpenSync VFormat Plugin"
HOMEPAGE="http://www.opensync.org"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/format-plugins/vformat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*"
RDEPEND="${DEPEND}"
