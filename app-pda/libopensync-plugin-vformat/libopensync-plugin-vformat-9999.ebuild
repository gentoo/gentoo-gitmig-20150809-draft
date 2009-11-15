# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-vformat/libopensync-plugin-vformat-9999.ebuild,v 1.2 2009/11/15 22:44:22 eva Exp $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="OpenSync VFormat Plugin"
HOMEPAGE="http://www.opensync.org"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/format-plugins/vformat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	test? ( dev-libs/check )"
