# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-config/ruby-config-0.3.ebuild,v 1.6 2004/08/22 04:25:30 weeve Exp $

DESCRIPTION="Utility to switch the ruby interpreter beging used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~arm ~hppa ~amd64 ~ia64 ~s390 macos ppc64"
IUSE=""

DEPEND="virtual/ruby"
S="${WORKDIR}"

src_install() {
	newsbin ${FILESDIR}/${P} ruby-config || die
}
