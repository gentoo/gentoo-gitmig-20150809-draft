# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-thumbnailers/thunar-thumbnailers-4.7.0.ebuild,v 1.5 2010/12/25 08:52:36 ssuominen Exp $

# Ensure sane upgrade path for users.

EAPI=3

DESCRIPTION="This package has been replaced. Use xfce-extra/tumbler instead soon as possible."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="xfce-extra/tumbler"

pkg_postinst() {
	ewarn
	ewarn "This is merely a convenience package for moving into xfce-extra/tumbler."
	ewarn
}
