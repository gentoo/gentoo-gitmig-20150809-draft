# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5.10.ebuild,v 1.2 2009/05/31 21:20:16 nixnut Exp $

KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="media-libs/audiofile"
