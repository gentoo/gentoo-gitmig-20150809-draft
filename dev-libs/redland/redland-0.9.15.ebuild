# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-0.9.15.ebuild,v 1.2 2004/02/22 07:13:11 vapier Exp $

DESCRIPTION="high-level interface for the Resource Description Framework"
HOMEPAGE="http://www.redland.opensource.ac.uk/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="perl python java tcltk php ruby libwww mysql"

DEPEND="perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	java? ( virtual/jdk )
	tcltk? ( dev-lang/tcl )
	php? ( dev-php/php )
	ruby? ( dev-lang/ruby )
	libwww? ( net-libs/libwww )
	mysql? ( dev-db/mysql )"

src_compile() {
	econf \
		`use_with perl` \
		`use_with python` \
		`use_with java` \
		`use_with tcltk tcl` \
		`use_with php` \
		`use_with ruby` \
		`use_with libwww` \
		`use_with mysql` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
