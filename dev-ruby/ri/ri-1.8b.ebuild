# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ri/ri-1.8b.ebuild,v 1.6 2004/04/16 14:54:31 dholm Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Ruby Interactive reference"
HOMEPAGE="http://www.pragmaticprogrammer.com/ruby/downloads/ri.html"
SRC_URI="mirror://sourceforge/rdoc/${P}.tgz"

SLOT="0"
LICENSE="Ruby"
KEYWORDS="alpha hppa mips sparc x86 ~ppc"

DEPEND=">=dev-lang/ruby-1.6.2"

src_install () {

	DESTDIR=${D} ruby install.rb
	dodoc COPYING ChangeLog README
}
