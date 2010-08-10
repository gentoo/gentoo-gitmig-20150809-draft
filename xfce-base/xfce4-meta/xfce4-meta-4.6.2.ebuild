# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-meta/xfce4-meta-4.6.2.ebuild,v 1.6 2010/08/10 15:56:23 jer Exp $

EAPI=2

DESCRIPTION="Xfce4 Desktop Environment (meta package)"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="minimal +session +svg"

RDEPEND="x11-themes/gtk-engines-xfce
	>=xfce-base/xfce4-panel-${PV}
	>=xfce-base/xfwm4-${PV}
	>=xfce-base/xfce-utils-${PV}
	>=xfce-base/xfdesktop-${PV}
	>=xfce-base/xfce4-settings-${PV}
	x11-themes/hicolor-icon-theme
	!minimal? ( media-fonts/dejavu
		x11-themes/xfce4-icon-theme )
	session? ( >=xfce-base/xfce4-session-${PV} )
	svg? ( gnome-base/librsvg )"
