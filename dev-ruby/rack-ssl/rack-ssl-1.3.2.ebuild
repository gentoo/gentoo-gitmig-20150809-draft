# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack-ssl/rack-ssl-1.3.2.ebuild,v 1.3 2012/04/04 09:58:44 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem eutils versionator

DESCRIPTION="Force SSL/TLS in your app."
HOMEPAGE="https://github.com/josh/rack-ssl/"
SRC_URI="https://github.com/josh/rack-ssl/tarball/v${PV} -> ${P}.tgz"
RUBY_S="josh-rack-ssl-*"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~ppc64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

ruby_add_rdepend "virtual/ruby-ssl"

ruby_add_bdepend "test? ( dev-ruby/rack-test )"
