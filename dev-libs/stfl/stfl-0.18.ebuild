# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/stfl/stfl-0.18.ebuild,v 1.4 2009/03/09 21:03:27 mr_bones_ Exp $

EAPI="2"
inherit eutils multilib perl-module python toolchain-funcs

DESCRIPTION="A library which implements a curses-based widget set for text terminals"
HOMEPAGE="http://www.clifford.at/stfl/"
SRC_URI="http://www.clifford.at/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples perl ruby"

DEPEND="sys-libs/ncurses[unicode]
		perl? ( dev-lang/swig dev-lang/perl )
		ruby? ( dev-lang/swig dev-lang/ruby )"

RDEPEND="sys-libs/ncurses[unicode]
		perl? ( dev-lang/perl )
		ruby? ( dev-lang/ruby )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s!-Os -ggdb!!" \
		-e "s!^all:.*!all: libstfl.a!" \
		Makefile

	epatch "${FILESDIR}/${P}-multilib.patch"
	python_version
	sed -i -e "s:/usr/lib/python2.4:${D}/usr/lib/python${PYVER}:" \
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

	dodir /usr/lib/python${PYVER}/lib-dynload
	emake -j1 prefix="/usr" DESTDIR="${D}" LIBDIR="$(get_libdir)" install || die "make install failed"

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
