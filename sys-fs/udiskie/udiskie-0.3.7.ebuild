# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udiskie/udiskie-0.3.7.ebuild,v 1.1 2011/05/20 14:29:39 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="An automatic disk mounting service using udisks"
HOMEPAGE="http://bitbucket.org/byronclark/udiskie"
SRC_URI="http://bitbucket.org/byronclark/${PN}/downloads/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	dev-python/notify-python
	dev-python/pygobject
	sys-fs/udisks"
DEPEND=""
