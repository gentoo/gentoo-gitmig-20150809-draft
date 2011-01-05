# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hotot/hotot-0.9.5.531.ebuild,v 1.1 2011/01/05 15:30:22 xmw Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils python versionator

DESCRIPTION="lightweight & open source microblogging client"
HOMEPAGE="http://hotot.org"
MY_P=${PN}-$(get_version_component_range 1-3)_hg~20101108.$(get_version_component_range 4)
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.7z"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/keybinder[python]
	dev-python/notify-python
	dev-python/python-distutils-extra
	>=dev-python/pywebkitgtk-1.1.8"
DEPEND="${RDEPEND}
	app-arch/p7zip"

S=${WORKDIR}/${PN}
