# Copyright 1999-2004 Gentoo Technologies, Inc.; acid DOT punk AT gmx DOT net
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rbbr/rbbr-0.4.0.ebuild,v 1.2 2004/03/24 23:30:30 mholzer Exp $

DESCRIPTION="Ruby Browser for modules/classes hierarchy and their constants and methods"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/hiki.cgi?rbbr"
SRC_URI="http://ruby-gnome2.sourceforge.jp/data/ruby-gnome2-api.tar.gz
	mirror://sourceforge/ruby-gnome2/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="Ruby"

DEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/ruby-gnome2-0.7.0
	>=dev-ruby/ri-0.8a"


src_unpack() {
	unpack ${A} ruby-gnome2-api.tar.gz
	cp -f ruby-gnome2-api/* rbbr-0.4.0/data/rbbr/rd/ || die "cp api failed"
}

src_compile() {
	ruby install.rb config || die "install.rb config failed"
	ruby install.rb setup || die "install.rb setup failed"
}

src_install() {
	ruby install.rb install --prefix=${D} || die "install.rb install failed"
}
