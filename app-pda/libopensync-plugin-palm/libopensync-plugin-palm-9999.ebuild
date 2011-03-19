# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-palm/libopensync-plugin-palm-9999.ebuild,v 1.2 2011/03/19 08:07:33 dirtyepic Exp $

EAPI="3"

inherit cmake-utils subversion

DESCRIPTION="OpenSync Palm Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/palm"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	>=app-pda/pilot-link-0.11.8
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

DOCS="README"
