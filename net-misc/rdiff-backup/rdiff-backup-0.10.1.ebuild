# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.10.1.ebuild,v 1.2 2002/10/04 21:25:00 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://www.stanford.edu/~bescoto/rdiff-backup/${P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/~bescoto/rdiff-backup/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.5
	>=dev-lang/python-2.2"
DEPEND="${RDEPEND}"

src_compile() {
	python setup.py build build_py build_ext build_scripts
}

src_install() {
	python setup.py install --prefix=${D}/usr
}
