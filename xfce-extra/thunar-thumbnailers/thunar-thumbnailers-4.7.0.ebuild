# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-thumbnailers/thunar-thumbnailers-4.7.0.ebuild,v 1.2 2010/09/28 07:30:49 ssuominen Exp $

# Ensure sane upgrade path for users.

EAPI=2

DESCRIPTION="A D-Bus service for applications to request thumbnails"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="xfce-base/tumbler"

pkg_postinst() {
	ewarn
	ewarn "This is merely a convenience package for moving into xfce-base/tumbler."
	ewarn
}
