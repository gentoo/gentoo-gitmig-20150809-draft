# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-tcpwrap/ruby-tcpwrap-0.6.ebuild,v 1.15 2009/12/24 17:22:02 graaff Exp $

inherit ruby

IUSE=""

DESCRIPTION="A TCP wrappers library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=ruby-tcpwrap"
SRC_URI="http://shugo.net/archive/ruby-tcpwrap/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~sparc x86"

DEPEND="
	net-libs/libident
	sys-apps/tcp-wrappers"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install(){

	ruby_src_install

	insinto /usr/share/doc/${PF}/html
	doins "${S}"/doc/*
}
