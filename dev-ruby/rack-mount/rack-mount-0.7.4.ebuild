# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack-mount/rack-mount-0.7.4.ebuild,v 1.2 2012/04/04 09:35:32 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="A stackable dynamic tree based Rack router."
HOMEPAGE="https://github.com/josh/rack-mount"
SRC_URI="https://github.com/josh/rack-mount/tarball/v${PV} -> ${P}.tgz"
S="${WORKDIR}/josh-${PN}-*"

LICENSE="MIT"
SLOT="0.7"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend ">=dev-ruby/rack-1.0.0"
