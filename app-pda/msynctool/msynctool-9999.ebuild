# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/msynctool/msynctool-9999.ebuild,v 1.1 2007/11/29 19:40:27 peper Exp $

inherit cmake-utils subversion

DESCRIPTION="OpenSync msync tool"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/multisync/trunk"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*"
RDEPEND="${DEPEND}"
