# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/plruby/plruby-0.5.4.ebuild,v 1.1 2010/06/27 07:38:03 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

GITHUB_USER="knu"

DESCRIPTION="plruby language for PostgreSQL"
HOMEPAGE="http://github.com/knu/postgresql-plruby"
SRC_URI="http://github.com/${GITHUB_USER}/postgresql-plruby/tarball/v${PV} -> ${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${DEPEND} dev-db/postgresql-server"
RDEPEND="${RDEPEND} dev-db/postgresql-server"

RUBY_PATCHES=( "${P}-fix-build-system.patch" )

S="${WORKDIR}"/${GITHUB_USER}-postgresql-plruby-*

each_ruby_configure() {
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	# We have injected --no-undefined in Ruby as a safety precaution
	# against broken ebuilds, but these bindings unfortunately rely on
	# the lazy load of other extensions; see bug #320545.
	find . -name Makefile -print0 | xargs -0 \
		sed -i -e 's:-Wl,--no-undefined::' || die "--no-undefined removal failed"

	emake || die
}

each_ruby_install() {
	emake install DESTDIR="${D}"
}

all_ruby_install() {
	dodoc Changes plruby.html plruby.rd README.en
}
