# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-audiofile/artsplugin-audiofile-3.5.10.ebuild,v 1.4 2009/06/06 10:09:15 maekke Exp $

KMNAME=kdemultimedia
KMMODULE=audiofile_artsplugin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="arts audiofile plugin"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="media-libs/audiofile"
