# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/text-format/text-format-0.61.ebuild,v 1.1 2003/05/17 10:33:53 mholzer Exp $

DESCRIPTION="Text::Format provides strong text formatting capabilities to Ruby"
HOMEPAGE="http://www.halostatue.ca/ruby/Text__Format.html"
SRC_URI="http://www.halostatue.ca/files/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/ruby"
S=${WORKDIR}/${P}

src_install() {
	dodoc Changelog
	dohtml -r doc/*
	DESTDIR=${D} ruby install.rb
}
