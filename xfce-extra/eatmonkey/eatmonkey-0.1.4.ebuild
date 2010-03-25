# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/eatmonkey/eatmonkey-0.1.4.ebuild,v 1.1 2010/03/25 11:09:09 ssuominen Exp $

EAPI=2
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
	net-misc/aria2
	dev-lang/ruby
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	XFCONF="--disable-dependency-tracking"
}

src_prepare() {
	sed -i \
		-e 's:/usr/local:/usr:' \
		src/eat{monkey,manager.rb} || die

	# compat18.rb has class to handle this, but it's not working for some reason
	sed -i \
		-e 's:Dir.exists:File.directory:' \
		src/eatsettings.rb || die

	xfconf_src_prepare
}
