# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/testunit/testunit-0.1.4.ebuild,v 1.2 2002/08/20 04:30:10 george Exp $

DESCRIPTION="Test::Unit is a unit testing framework for the Ruby language"
HOMEPAGE="http://testunit.talbott.ws/"
SRC_URI="http://testunit.talbott.ws/packages/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/ruby-1.6.7"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_install () {
	ruby setup.rb config --prefix=${D}/usr || die
	ruby setup.rb setup || die
	ruby setup.rb install || die
	dodoc ChangeLog README TODO

	dohtml -r doc/ 
	dohtml -r examples
}
