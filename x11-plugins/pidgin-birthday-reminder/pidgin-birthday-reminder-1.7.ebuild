# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-birthday-reminder/pidgin-birthday-reminder-1.7.ebuild,v 1.1 2012/05/28 23:14:03 hasufell Exp $

EAPI=4

DESCRIPTION="Plugin for Pidgin that reminds you of your buddies birthdays"
HOMEPAGE="http://launchpad.net/pidgin-birthday-reminder"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
