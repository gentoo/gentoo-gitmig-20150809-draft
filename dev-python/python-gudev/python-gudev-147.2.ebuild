# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gudev/python-gudev-147.2.ebuild,v 1.1 2010/11/28 06:45:25 ford_prefect Exp $

EAPI=2
PYTHON_DEPEND="*"

inherit autotools base python

DESCRIPTION="Python binding to the GUDev udev helper library"
HOMEPAGE="http://github.com/nzjrs/python-gudev"
SRC_URI="https://github.com/nzjrs/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-fs/udev-147[extras]
	dev-python/pygobject"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/nzjrs-${PN}-ee8a644

DOCS="AUTHORS NEWS README"

src_prepare() {
	eautoreconf
}
