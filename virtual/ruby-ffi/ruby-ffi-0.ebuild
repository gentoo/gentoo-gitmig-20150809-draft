# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-ffi/ruby-ffi-0.ebuild,v 1.6 2010/09/30 01:39:39 ranger Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby ffi library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-ruby/ffi[ruby_targets_ruby18] )
	ruby_targets_ruby19? ( dev-ruby/ffi[ruby_targets_ruby19] )
	ruby_targets_ree18? ( dev-ruby/ffi[ruby_targets_ree18] )
	ruby_targets_jruby? ( dev-java/jruby )"
DEPEND=""

pkg_setup() { :; }
src_unpack() { :; }
src_prepare() { :; }
src_compile() { :; }
src_install() { :; }
pkg_preinst() { :; }
pkg_postinst() { :; }
