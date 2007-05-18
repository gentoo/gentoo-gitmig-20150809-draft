# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-archive/thunar-archive-0.2.4-r1.ebuild,v 1.7 2007/05/18 18:22:14 armin76 Exp $

inherit xfce44

xfce44

MY_P="${PN}-plugin-${PV}"

DESCRIPTION="Thunar archive plugin"
HOMEPAGE="http://www.foo-projects.org/~benny/projects/thunar-archive-plugin"
SRC_URI="http://download2.berlios.de/xfce-goodies/${MY_P}${COMPRESS}"

KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="|| ( xfce-extra/xarchiver app-arch/file-roller xfce-extra/squeeze )"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

xfce44_goodies_thunar_plugin
