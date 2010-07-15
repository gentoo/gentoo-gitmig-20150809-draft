# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kffmpegthumbnailer/kffmpegthumbnailer-1.1.0.ebuild,v 1.3 2010/07/15 20:38:46 maekke Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A thumbnailer for KDE based on ffmpegthumbnailer"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer/"
SRC_URI="http://ffmpegthumbnailer.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND=">=media-video/ffmpegthumbnailer-2"

DOCS="Changelog README"
