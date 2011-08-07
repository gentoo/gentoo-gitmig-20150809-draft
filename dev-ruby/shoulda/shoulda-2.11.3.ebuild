# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shoulda/shoulda-2.11.3.ebuild,v 1.2 2011/08/07 14:53:10 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CONTRIBUTION_GUIDELINES.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Making tests easy on the fingers and eyes"
HOMEPAGE="http://thoughtbot.com/projects/shoulda"
SRC_URI="https://github.com/thoughtbot/${PN}/tarball/v${PV} -> ${P}.tar.gz"
S="${WORKDIR}/thoughtbot-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

# tests seem to be quite broken :( They require working version of
# various rails versions. There appear to be unit and matcher tests but
# they can't be run on their own.
RESTRICT=test
