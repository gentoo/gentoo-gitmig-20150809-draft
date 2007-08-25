# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-config/ruby-config-0.3.2.ebuild,v 1.13 2007/08/25 13:07:38 vapier Exp $

inherit eutils

DESCRIPTION="Utility to switch the ruby interpreter being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="!<dev-ruby/ri-1.8b-r1"
PDEPEND="virtual/ruby"

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/${PN}-0.3.2 . || die
}

src_install() {
	newsbin ${PN}-0.3.2 ruby-config || die
}
