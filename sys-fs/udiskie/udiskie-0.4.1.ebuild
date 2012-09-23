# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udiskie/udiskie-0.4.1.ebuild,v 1.3 2012/09/23 08:23:41 phajdan.jr Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="An automatic disk mounting service using udisks"
HOMEPAGE="http://bitbucket.org/byronclark/udiskie"
SRC_URI="mirror://bitbucket/byronclark/${PN}/downloads/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	dev-python/notify-python
	dev-python/pygobject:2
	dev-python/pyxdg
	sys-fs/udisks:0"
DEPEND=""
