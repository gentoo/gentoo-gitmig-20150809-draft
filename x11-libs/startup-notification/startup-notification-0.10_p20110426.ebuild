# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/startup-notification/startup-notification-0.10_p20110426.ebuild,v 1.4 2011/04/26 15:25:18 ssuominen Exp $

EAPI=4
XORG_EAUTORECONF=yes
inherit xorg-2

DESCRIPTION="Application startup notification and feedback library"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/startup-notification"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="LGPL-2 MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libX11
	>x11-libs/libxcb-1.6
	>=x11-libs/xcb-util-0.3.8"
DEPEND="${RDEPEND}
	x11-proto/xproto"

DOCS=( AUTHORS ChangeLog NEWS doc/startup-notification.txt )
