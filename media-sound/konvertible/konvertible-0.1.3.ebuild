# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/konvertible/konvertible-0.1.3.ebuild,v 1.1 2009/12/23 21:36:53 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A program to convert audio formats with FFmpeg"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Konvertible?content=116892"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/116892-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

RDEPEND="media-video/ffmpeg"

DOCS="ChangeLog README TODO"
