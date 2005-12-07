# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xslt/ruby-xslt-0.9.2.ebuild,v 1.1 2005/12/07 00:08:21 caleb Exp $

inherit ruby

MY_P="${PN}_${PV}"

DESCRIPTION="A Ruby class for processing XSLT"
HOMEPAGE="http://www.rubyfr.net/"
SRC_URI="http://gregoire.lejeune.free.fr/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

USE_RUBY="ruby18 ruby19"

DEPEND=">=dev-lang/ruby-1.8
	>=dev-libs/libxslt-1.1.12"

S="${WORKDIR}/${PN}"

src_compile() {
	econf --enable-error-handler || die "could not configure"
	emake || die "emake failed"

	if use doc; then
		emake doc
	fi
}

src_install() {
	ruby_einstall "$@" || die

	if use doc; then
		docinto doc
		dohtml -r doc
	fi
}
