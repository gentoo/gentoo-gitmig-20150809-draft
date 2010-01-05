# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete-facebook/kopete-facebook-0.1.3.ebuild,v 1.3 2010/01/05 15:59:34 jer Exp $

EAPI=2
inherit kde4-base

MY_PN="dmacvicar-kopete-facebook-ffc26f6"

DESCRIPTION="Facebook Chat support for Kopete"
HOMEPAGE="http://duncan.mac-vicar.com/blog/archives/tag/facebook"
SRC_URI="http://github.com/dmacvicar/kopete-facebook/tarball/release_0_1_3 -> ${MY_PN}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/qjson
	>=kde-base/kopete-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	!net-im/kopete-facebook:0
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

S=${WORKDIR}/${MY_PN}
