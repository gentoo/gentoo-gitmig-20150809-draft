# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-config/ruby-config-0.2.ebuild,v 1.1 2004/01/30 07:50:34 usata Exp $

DESCRIPTION="Utility to switch the ruby interpreter beging used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

IUSE=""

DEPEND="dev-lang/ruby"
#RDEPEND=""

src_install() {

	newsbin ${FILESDIR}/ruby-config.sh ruby-config
	dodir /usr/bin
	dosym /usr/{s,}bin/ruby-config
}
