# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/osynctool/osynctool-9999.ebuild,v 1.1 2010/05/26 12:43:13 bangert Exp $

inherit cmake-utils subversion

DESCRIPTION="Command line interface for OpenSync"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/osynctool/trunk"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*"
RDEPEND="${DEPEND}"
