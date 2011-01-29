# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/eatmonkey/eatmonkey-0.1.4.ebuild,v 1.4 2011/01/29 20:55:47 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A download manager that works exclusively with aria2"
HOMEPAGE="http://goodies.xfce.org/projects/applications/eatmonkey"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/libunique-1
	>=xfce-base/libxfce4util-4.4
	>=net-libs/libsoup-2.26"
RDEPEND="${COMMON_DEPEND}
	>=net-misc/aria2-1.9.0[bittorrent,xmlrpc]
	dev-lang/ruby
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-syntax.patch )
	XFCONF=(
		--disable-dependency-tracking
		)

	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	sed -i \
		-e 's:/usr/local:/usr:' \
		src/eat{monkey,manager.rb} || die

	xfconf_src_prepare
}
