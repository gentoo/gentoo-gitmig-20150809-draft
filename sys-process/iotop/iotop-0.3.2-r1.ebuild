# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/iotop/iotop-0.3.2-r1.ebuild,v 1.2 2009/11/26 15:11:13 grobian Exp $

EAPI=2

inherit distutils linux-info

DESCRIPTION="Iotop has a top-like UI used to show which process is using the I/O"
HOMEPAGE="http://guichaz.free.fr/iotop/"
SRC_URI="http://guichaz.free.fr/iotop//files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-linux"
IUSE=""

RDEPEND=">=dev-lang/python-2.5[ncurses]
	dev-python/setuptools"
DEPEND="${RDEPEND}"

CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASKSTATS"
DOCS="NEWS README THANKS"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-rm-bundled-setuptools.patch"
}

src_install() {
	distutils_src_install
	doman iotop.1
}
