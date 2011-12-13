# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.6.7.ebuild,v 1.1 2011/12/13 19:26:15 fauli Exp $

EAPI=2
USE_RUBY="ruby18"

inherit gnome2 ruby-ng

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="evo"

DOCS="ChangeLog README TODO doc/BUGS doc/cuecat_support.rdoc doc/FAQ doc/HACKING doc/NEWS"

ruby_add_rdepend "
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.16.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/imagesize-0.1.1
	dev-ruby/hpricot
	evo? ( >=dev-ruby/revolution-0.5 )"

ruby_add_bdepend "dev-ruby/rake"

DEPEND="${DEPEND} app-text/scrollkeeper"

RUBY_PATCHES=(
	"${FILESDIR}/${PN}-0.6.6-Rakefile.patch"
)

each_ruby_compile() {
	${RUBY} -S rake || die
}

each_ruby_install() {
	export DESTDIR="${D}" PREFIX=/usr
	rake install_package_staging || die
}

all_ruby_install() {
	[ -n "${DOCS}" ] && dodoc ${DOCS} || die "Failed to install documentation"
}

pkg_postinst() {
	unset PREFIX

	gnome2_gconf_install

	# For the next line see bug #76726
	"${ROOT}/usr/bin/gconftool-2" --shutdown

	echo
	elog "To enable some book providers you will need to emerge"
	elog "additional packages:"
	echo
	elog "  For the Deastore book provider:"
	elog "    dev-ruby/htmlentities"
	echo
	elog "  For Z39.50 support and the Library of Congress and"
	elog "  British Library book proviers:"
	elog "    dev-ruby/ruby-zoom"
}
