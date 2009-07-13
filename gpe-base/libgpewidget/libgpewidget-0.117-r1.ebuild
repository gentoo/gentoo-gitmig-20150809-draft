# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libgpewidget/libgpewidget-0.117-r1.ebuild,v 1.5 2009/07/13 23:34:50 miknix Exp $

EAPI=2
GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="A collection of widgets and other common code shared by many GPE applications."

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="+cairo"

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.6.3
	media-libs/libpng
	cairo? (
		x11-libs/cairo[X]
		x11-libs/pango[X]
	)
"

DEPEND="${RDEPEND}
	>=gpe-base/gpe-icons-0.25
	sys-devel/gettext
	x11-proto/kbproto
	x11-proto/renderproto
	x11-proto/xproto
"

GPE_DOCS="ChangeLog"
GPECONF="$(use_enable cairo)"
