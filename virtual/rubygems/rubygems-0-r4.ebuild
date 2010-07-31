# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/rubygems/rubygems-0-r4.ebuild,v 1.1 2010/07/31 18:31:40 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby gems tools"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-ruby/rubygems[ruby_targets_ruby18] )
	ruby_targets_ruby19? ( dev-ruby/rubygems[ruby_targets_ruby19] )
	ruby_targets_jruby? ( dev-ruby/rubygems[ruby_targets_jruby] )
	ruby_targets_ree18? ( dev-ruby/rubygems[ruby_targets_ree18] )"
DEPEND=""

pkg_setup() { :; }
src_unpack() { :; }
src_prepare() { :; }
src_compile() { :; }
src_install() { :; }
pkg_preinst() { :; }
pkg_postinst() { :; }
