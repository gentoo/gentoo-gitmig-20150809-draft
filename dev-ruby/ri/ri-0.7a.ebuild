# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Richard Lowe <richlowe@richlowe.net>
# Maintainer: Tools Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ri/ri-0.7a.ebuild,v 1.1 2002/02/01 13:34:36 karltk Exp $

S="${WORKDIR}/ri"
DESCRIPTION="Ruby Interactive reference"
SRC_URI="http://www.pragmaticprogrammer.com/ruby/downloads/files/${P}.tgz"
HOMEPAGE="http://www.pragmaticprogrammer.com/ruby/downloads/ri.html"
DEPEND=">=dev-lang/ruby-1.6.2" # Specified in ${HOMEPAGE}

src_unpack () {
   unpack ${A}
   cd ${S}
   patch < ${FILESDIR}/${P}-gentoo.patch || die
}


src_install () {
   dodoc COPYING ChangeLog README
   ruby install.rb
}
