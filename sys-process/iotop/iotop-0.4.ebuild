# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/iotop/iotop-0.4.ebuild,v 1.7 2010/03/23 20:26:37 ranger Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="ncurses"
SUPPORT_PYTHON_ABIS="1"

inherit distutils linux-info

DESCRIPTION="Iotop has a top-like UI used to show which process is using the I/O"
HOMEPAGE="http://guichaz.free.fr/iotop/"
SRC_URI="http://guichaz.free.fr/iotop//files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ppc ~sparc x86 ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="2.4 3.*"

CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASK_DELAY_ACCT"
DOCS="NEWS README THANKS"

src_install() {
	distutils_src_install
	doman iotop.1
}
