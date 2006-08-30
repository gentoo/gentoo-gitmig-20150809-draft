# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomeprintui/ruby-gnomeprintui-0.15.0.ebuild,v 1.1 2006/08/30 11:21:06 pclouds Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby bindings for gnomeprintui"
KEYWORDS="~ia64 ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/libgnomeprintui-2.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-gnomeprint-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"

# Needed to generate rblibgnomeprintversion.h
src_compile() {
	cd ${WORKDIR}/ruby-gnome2-all-${PV}/gnomeprint
	ruby extconf.rb || die "ruby-libgnomeprint's extconf.rb failed"

	cd ${WORKDIR}/ruby-gnome2-all-${PV}/gnomeprintui
	ruby extconf.rb || die "ruby-libgnomeprintui's extconf.rb failed"
	emake CC=${CC:-gcc} CXX=${CXX:-g++} || die "emake failed"
}
