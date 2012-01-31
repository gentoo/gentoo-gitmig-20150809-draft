# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-activity-journal/gnome-activity-journal-0.8.0.ebuild,v 1.1 2012/01/31 17:26:06 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils versionator

DIR_PV=$(get_version_component_range 1-2)

DESCRIPTION="Tool for easily browsing and finding files on your computer"
HOMEPAGE="https://launchpad.net/gnome-activity-journal/"
SRC_URI="http://launchpad.net/gnome-activity-journal/${DIR_PV}/${PV}/+download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=gnome-extra/zeitgeist-0.8.2"
DEPEND="dev-python/python-distutils-extra"
