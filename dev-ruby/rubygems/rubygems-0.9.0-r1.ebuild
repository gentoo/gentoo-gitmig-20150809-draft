# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubygems/rubygems-0.9.0-r1.ebuild,v 1.2 2007/01/21 08:15:04 pclouds Exp $

RUBY_BUG_145222=yes
inherit ruby

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/rubygems/"
LICENSE="Ruby"

# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/11289/${P}.tgz"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE="examples"
DEPEND=">=dev-lang/ruby-1.8"

PATCHES="${FILESDIR}/no_post_install.patch
	${FILESDIR}/${P}-build-c-extensions.patch"
USE_RUBY="ruby18"

src_compile() {
	return
}

src_install() {
	ver=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["MAJOR"] + "." + Config::CONFIG["MINOR"]')
	GEM_HOME=${D}/usr/lib/ruby/gems/$ver ruby_src_install
	cp "${FILESDIR}/auto_gem.rb" "${D}"/$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
	keepdir /usr/lib/ruby/gems/$ver/doc
	doenvd "${FILESDIR}/10rubygems"
}

pkg_postinst()
{
	ewarn "If you have previously switched to using ruby18_with_gems using ruby-config, this"
	ewarn "package has removed that file and makes it unnecessary anymore.	Please use ruby-config"
	ewarn "to revert back to ruby18."
}

pkg_postrm()
{
	# If we potentially downgraded, then getting rid of RUBYOPT from env.d is probably a smart idea.
	env-update
	source /etc/profile
}
