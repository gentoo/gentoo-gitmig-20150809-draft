# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-meta/xfce4-meta-4.8.ebuild,v 1.9 2011/09/18 07:46:04 ssuominen Exp $

EAPI=4

DESCRIPTION="The Xfce Desktop Environment (meta package)"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="minimal +session +svg"

RDEPEND="x11-themes/gtk-engines-xfce
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/xfwm4-4.8
	>=xfce-base/xfce-utils-4.8
	>=xfce-base/xfdesktop-4.8
	>=xfce-base/xfce4-settings-4.8
	x11-themes/hicolor-icon-theme
	!minimal? ( media-fonts/dejavu
		virtual/freedesktop-icon-theme )
	session? ( >=xfce-base/xfce4-session-4.8 )
	svg? ( gnome-base/librsvg )"
