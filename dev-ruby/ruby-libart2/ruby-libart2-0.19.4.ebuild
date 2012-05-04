# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libart2/ruby-libart2-0.19.4.ebuild,v 1.9 2012/05/04 18:47:55 jdhore Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit eutils ruby-ng-gnome2

DESCRIPTION="Ruby Libart2 bindings"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=media-libs/libart_lgpl-2"
DEPEND="${DEPEND}
	>=media-libs/libart_lgpl-2
	virtual/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
}
