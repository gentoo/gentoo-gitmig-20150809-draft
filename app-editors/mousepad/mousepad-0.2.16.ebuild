# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mousepad/mousepad-0.2.16.ebuild,v 1.3 2009/06/09 15:00:19 darkside Exp $

EAPI=1

inherit xfce4

XFCE_VERSION=4.6.0

xfce4_core

DESCRIPTION="Text editor"
HOMEPAGE="http://www.xfce.org/projects/mousepad/"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
