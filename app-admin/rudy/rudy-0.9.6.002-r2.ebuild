# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rudy/rudy-0.9.6.002-r2.ebuild,v 1.1 2010/02/19 12:04:38 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RESTRICT=test
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc examples/authorize.rb examples/gem-test.rb
	examples/solaris.rb examples/windows.rb"

RUBY_FAKEGEM_EXTRAINSTALL="Rudyfile"

inherit ruby-fakegem eutils

DESCRIPTION="Not your grandparents' EC2 deployment tool"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="http://github.com/solutious/${PN}/tarball/${P} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/solutious-${PN}-eadcfa3"

ruby_add_rdepend '
	>=dev-ruby/amazon-ec2-0.5.0
	>=dev-ruby/highline-1.5.1
	>=dev-ruby/aws-s3-0.6.1
	>=dev-ruby/storable-0.5.8
	>=dev-ruby/gibbler-0.7.1
	>=dev-ruby/sysinfo-0.7.0
	>=dev-ruby/caesars-0.7.3
	>=dev-ruby/drydock-0.6.6
	>=dev-ruby/annoy-0.5.5
	>=dev-ruby/attic-0.4.0
	>=dev-ruby/rye-0.8.11'

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}+amazon-ec2-0.9.4.patch
}
