# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-2.4.0.ebuild,v 1.1 2006/01/12 14:05:02 caleb Exp $

inherit ruby eutils

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

MY_P=${P/zentest/ZenTest}
S=${WORKDIR}/${MY_P}

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/6468/${MY_P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"
DEPEND="virtual/ruby"

src_unpack() {
	ruby_src_unpack
	epatch ${FILESDIR}/zentest-dirfix.diff
	epatch ${FILESDIR}/zentest-fixrubyloc.diff
}

src_install() {
	dodir ${ROOT}/usr/bin
	make DESTDIR=${D} install
}
