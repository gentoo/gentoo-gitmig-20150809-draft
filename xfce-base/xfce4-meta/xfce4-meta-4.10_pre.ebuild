# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-meta/xfce4-meta-4.10_pre.ebuild,v 1.3 2012/04/20 20:34:39 ssuominen Exp $

EAPI=4

DESCRIPTION="The Xfce Desktop Environment (meta package)"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="minimal +svg"

RDEPEND=">=x11-themes/gtk-engines-xfce-2.99.3:0
	x11-themes/hicolor-icon-theme
	>=xfce-base/xfce4-appfinder-4.9.5
	>=xfce-base/xfce4-panel-4.9.2
	>=xfce-base/xfce4-session-4.9.2
	>=xfce-base/xfce4-settings-4.9.5
	>=xfce-base/xfdesktop-4.9.3
	>=xfce-base/xfwm4-4.9.1
	!minimal? (
		media-fonts/dejavu
		virtual/freedesktop-icon-theme
		)
	svg? ( gnome-base/librsvg )"
