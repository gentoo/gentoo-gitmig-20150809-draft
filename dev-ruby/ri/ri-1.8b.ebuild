# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ri/ri-1.8b.ebuild,v 1.11 2005/02/06 23:44:53 kumba Exp $

DESCRIPTION="Ruby Interactive reference"
HOMEPAGE="http://www.pragmaticprogrammer.com/ruby/downloads/ri.html"
SRC_URI="mirror://sourceforge/rdoc/${P}.tgz"

SLOT="0"
LICENSE="Ruby"
KEYWORDS="alpha hppa mips sparc x86 ~ppc amd64"

IUSE=""
DEPEND="=dev-lang/ruby-1.6*"

S=${WORKDIR}/${PN}

src_install () {

	DESTDIR=${D} ruby16 install.rb || die "install.rb failed"
	dodoc COPYING ChangeLog README
}
