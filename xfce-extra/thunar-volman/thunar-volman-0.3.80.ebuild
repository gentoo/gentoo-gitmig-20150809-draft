# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.3.80.ebuild,v 1.2 2009/08/23 17:56:55 ssuominen Exp $

EAPI=2

inherit xfce4

xfce4_goodies

DESCRIPTION="Thunar volume management"
HOMEPAGE="http://foo-projects.org/~benny/projects/thunar-volman"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="dev-libs/dbus-glib
	sys-apps/hal
	>=xfce-base/exo-0.3.8[hal]
	>=xfce-base/thunar-1"

DOCS="AUTHORS ChangeLog NEWS README THANKS"
