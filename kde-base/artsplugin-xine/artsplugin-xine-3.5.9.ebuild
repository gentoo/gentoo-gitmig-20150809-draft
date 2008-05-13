# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-xine/artsplugin-xine-3.5.9.ebuild,v 1.5 2008/05/13 13:50:52 jer Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=xine_artsplugin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="arts xine plugin"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86"
IUSE=""
DEPEND=">=media-libs/xine-lib-1.0"
