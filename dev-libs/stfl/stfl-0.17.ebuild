# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/stfl/stfl-0.17.ebuild,v 1.1 2007/09/04 22:42:32 ticho Exp $

inherit perl-module toolchain-funcs

DESCRIPTION="A library which implements a curses-based widget set for text terminals"
HOMEPAGE="http://www.clifford.at/stfl/"
SRC_URI="http://www.clifford.at/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86"

IUSE="examples perl ruby"

DEPEND="sys-libs/ncurses
		perl? ( dev-lang/swig dev-lang/perl )
		ruby? ( dev-lang/swig dev-lang/ruby )"

RDEPEND="sys-libs/ncurses
		perl? ( dev-lang/perl )
		ruby? ( dev-lang/ruby )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i \
		-e "s!-Os -ggdb!!" \
		-e "s!^all:.*!all: libstfl.a!" \
		Makefile

	sed -i -e "s:/usr/lib/python2.4:${D}/usr/lib/python2.4:" \
		python/Makefile.snippet

	if ! use perl; then
		echo "FOUND_PERL5=0" >>Makefile.cfg
	fi
	if ! use ruby; then
		echo "FOUND_RUBY=0" >>Makefile.cfg
	fi
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	local exdir="/usr/share/doc/${PF}/examples"

	dodir /usr/lib/python2.4/lib-dynload
	emake -j1 prefix="/usr" DESTDIR="${D}" install || die "make install failed"

	dodoc README

	if use examples; then
		insinto ${exdir}
		doins example.{c,stfl}
		insinto  ${exdir}/python
		doins python/example.py
		if use perl; then
			insinto ${exdir}/perl
			doins perl5/example.pl
		fi
		if use ruby; then
			insinto ${exdir}/ruby
			doins ruby/example.rb
		fi
	fi

	fixlocalpod
}
