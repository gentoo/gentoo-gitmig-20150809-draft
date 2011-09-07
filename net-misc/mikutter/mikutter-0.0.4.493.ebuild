# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mikutter/mikutter-0.0.4.493.ebuild,v 1.1 2011/09/07 22:33:34 naota Exp $

EAPI=3

USE_RUBY="ruby18 ruby19"

inherit ruby-ng

MY_P="${PN}.${PV}"

DESCRIPTION="mikutter is simple, powerful and moeful twitter client"
HOMEPAGE="http://mikutter.hachune.net/"
SRC_URI="http://mikutter.hachune.net/bin/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libnotify sound"

DEPEND=""
RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.7)[ssl]
	libnotify? ( x11-libs/libnotify )
	sound? ( media-sound/alsa-utils )"

ruby_add_rdepend "dev-ruby/ruby-gtk2
	dev-ruby/rcairo
	dev-ruby/httpclient"

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
