# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/passenger/passenger-1.0.1.ebuild,v 1.1 2008/04/25 10:56:33 hollow Exp $

inherit apache-module flag-o-matic ruby

DESCRIPTION="Passenger (a.k.a. mod_rails) makes deployment of Ruby on Rails applications a breeze"
HOMEPAGE="http://modrails.com/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-lang/ruby-1.8.5
	>=dev-ruby/rubygems-0.9.0
	>=dev-ruby/rake-0.8.1
	>=dev-ruby/fastthread-1.0.1
	>=dev-ruby/rspec-1.1.2
	>=dev-ruby/rails-1.2.0"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="${S}/ext/apache2/mod_${PN}.so"
APACHE2_MOD_CONF="30_mod_${PN}"
APACHE2_MOD_DEFINE="PASSENGER"

need_apache2_2

pkg_setup() {
	use debug && append-flags -DPASSENGER_DEBUG
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-gentoo.patch

	# set version here to prevent Rakefile parsing
	sed -i -e "s/\(PASSENGER_VERSION\) = .*/\1 = '${PV}'/" \
		lib/passenger/request_handler.rb
}

src_compile() {
	cd "${S}"/ext/passenger
	ruby_src_compile

	cd "${S}"
	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	rake apache2 || die "rake apache2 failed"
}

src_install() {
	( # dont want to pollute calling env
		insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
		doins -r lib/passenger
	) || die "failed to install passenger lib"

	dobin bin/passenger-spawn-server

	cd "${S}"/ext/passenger
	ruby_einstall

	apache-module_src_install
}
