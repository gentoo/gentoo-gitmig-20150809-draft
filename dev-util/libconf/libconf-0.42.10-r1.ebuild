# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/libconf/libconf-0.42.10-r1.ebuild,v 1.2 2006/11/28 20:06:20 dev-zero Exp $

inherit multilib toolchain-funcs

MY_P=perl-Libconf-${PV}

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

S=${WORKDIR}/${MY_P}

bindings() {
	local mybindings
	mybindings="c bash"
	use python && mybindings="${mybindings} python"
	use ruby && mybindings="${mybindings} ruby"
	echo ${mybindings}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Multilib fix
	sed -i \
		-e "/^LIB_DIR/ { s:lib:$(get_libdir): }" \
		-e 's/^CF=-Wall/CF=$(CFLAGS)/' \
		bindings/c/src/Makefile || die "bad sed"
}
src_compile() {
	emake \
		BINDINGS="$(bindings)" \
		CC=$(tc-getCC) || die "make failed"
}

src_install() {
	emake BINDINGS="$(bindings)" PREFIX="${D}/usr" DESTDIR="${D}" ROOT="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog \
		bindings/ruby/src/{AUTHORS,README} \
		bindings/python/src/README
}
