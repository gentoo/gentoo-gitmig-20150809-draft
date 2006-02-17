# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibacl/pylibacl-0.2.1.ebuild,v 1.6 2006/02/17 20:12:27 hansmi Exp $

inherit distutils

DESCRIPTION="Python interface to libacl"
HOMEPAGE="http://sourceforge.net/projects/pylibacl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc sparc x86"
IUSE=""

DEPEND="virtual/python
		sys-apps/acl"
RDEPEND="${DEPEND}"
