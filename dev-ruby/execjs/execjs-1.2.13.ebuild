# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/execjs/execjs-1.2.13.ebuild,v 1.1 2011/12/30 12:39:32 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper for UglifyJS JavaScript compressor."
HOMEPAGE="https://github.com/lautis/uglifier"
SRC_URI="https://github.com/sstephenson/execjs/tarball/v${PV} -> ${P}-git.tgz"
RUBY_S="sstephenson-execjs-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

ruby_add_rdepend ">=dev-ruby/multi_json-1.0"

# execjs supports various javascript runtimes. They are listed in order
# as per the documentation. For now only include the ones already in the
# tree.

# therubyracer, therubyrhino, johnson, mustang, node.js, spidermonkey

# spidermonkey doesn't pass the test suite:
# https://github.com/sstephenson/execjs/issues/62

RDEPEND="${RDEPEND} || ( net-libs/nodejs )"
