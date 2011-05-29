# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mikutter/mikutter-0.0.3.0.ebuild,v 1.1 2011/05/29 14:51:42 naota Exp $

EAPI=3

USE_RUBY="ruby18"

inherit ruby-ng

MY_P="${PN}.${PV}"

DESCRIPTION="mikutter is simple, powerful and moeful twitter client"
HOMEPAGE="http://mikutter.hachune.net/"
SRC_URI="http://mikutter.hachune.net/bin/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libnotify sqlite"

DEPEND=""
RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.7)[ssl]
	libnotify? ( x11-libs/libnotify )"

ruby_add_rdepend "dev-ruby/ruby-gtk2
	dev-ruby/ruby-hmac
	dev-ruby/httpclient
	sqlite? ( dev-ruby/sqlite3-ruby )"

S="${WORKDIR}/${PN}"

each_ruby_install() {
	exeinto /usr/share/mikutter
	doexe mikutter.rb
	insinto /usr/share/mikutter
	doins -r core plugin
	exeinto /usr/bin
	doexe "${FILESDIR}"/mikutter
	dodoc README
}
