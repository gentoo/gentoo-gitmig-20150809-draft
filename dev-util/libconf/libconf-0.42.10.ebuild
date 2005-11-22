# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/libconf/libconf-0.42.10.ebuild,v 1.1 2005/11/22 17:34:38 dams Exp $

MY_P=perl-${PN/l/L}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Centralized abstraction layer for system configuration files"
HOMEPAGE="http://libconf.net/"
SRC_URI="http://libconf.net/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="python ruby"
DEPEND="dev-lang/perl
dev-perl/DelimMatch
dev-perl/XML-Twig
python? ( >=dev-lang/python-2.4.2 )
ruby? ( >=dev-lang/ruby-1.8.3 )"

if use python; then
	mypython="python"
fi

if use ruby; then
	myruby="ruby"
fi

mybindings="c ${mypython} ${myruby} bash";

src_compile() {
	emake "BINDINGS=${mybindings}" || die "make failed"
	make "BINDINGS=${mybindings}" test || die "make test failed"
}

src_install() {
	einstall "BINDINGS=${mybindings}" PREFIX=${D}/usr ROOT=${D}
	dodoc AUTHORS COPYING ChangeLog \
		bindings/ruby/src/AUTHORS \
		bindings/ruby/src/README \
		bindings/python/src/README
}
