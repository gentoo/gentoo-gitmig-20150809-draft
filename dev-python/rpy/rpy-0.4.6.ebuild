# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-0.4.6.ebuild,v 1.5 2006/10/21 01:42:56 agriffis Exp $

inherit distutils

DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net"
SRC_URI="mirror://sourceforge/rpy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
IUSE=""
DEPEND="virtual/python
	=dev-lang/R-2.2*
	dev-python/numeric"


src_install() {
	distutils_src_install

	# add R libs to ld.so.conf
	insinto /etc/env.d
	doins ${FILESDIR}/90rpy
}

pkg_postinst() {
	env-update
}
