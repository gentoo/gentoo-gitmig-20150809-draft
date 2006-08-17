# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibacl/pylibacl-0.2.1.ebuild,v 1.11 2006/08/17 19:32:54 corsair Exp $

inherit distutils

DESCRIPTION="Python interface to libacl"
HOMEPAGE="http://sourceforge.net/projects/pylibacl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="virtual/python
		sys-apps/acl"
RDEPEND="${DEPEND}"
