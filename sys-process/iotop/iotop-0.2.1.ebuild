# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/iotop/iotop-0.2.1.ebuild,v 1.5 2009/01/31 14:43:30 jer Exp $

inherit distutils linux-info

DESCRIPTION="Iotop has a top-like UI used to show which process is using the I/O."
HOMEPAGE="http://guichaz.free.fr/iotop/"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~sparc x86"
IUSE=""
RDEPEND=">=dev-lang/python-2.5"
DEPEND="${RDEPEND}"
CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASKSTATS"
DOCS="THANKS"

src_install() {
	distutils_src_install
	doman iotop.1
}
