# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-xine/artsplugin-xine-3.5.10.ebuild,v 1.4 2009/06/06 11:15:59 maekke Exp $

KMNAME=kdemultimedia
KMMODULE=xine_artsplugin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="arts xine plugin"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="x11-libs/libXext
	>=media-libs/xine-lib-1.0"
