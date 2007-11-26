# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-python/libopensync-plugin-python-9999.ebuild,v 1.1 2007/11/26 20:23:01 peper Exp $

inherit cmake-utils subversion

DESCRIPTION="OpenSync Python Module"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/python-module"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	>=dev-lang/python-2.0"
RDEPEND="${DEPEND}"
