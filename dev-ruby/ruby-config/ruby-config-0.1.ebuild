# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-config/ruby-config-0.1.ebuild,v 1.1 2004/01/29 18:02:15 usata Exp $

DESCRIPTION="Utility to switch the ruby interpreter beging used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

IUSE=""

DEPEND="dev-lang/ruby"
#RDEPEND=""

src_install() {

	newsbin ${FILESDIR}/ruby-config.sh ruby-config
	dodir /usr/bin
	dosym /usr/{s,}bin/ruby-config
}
