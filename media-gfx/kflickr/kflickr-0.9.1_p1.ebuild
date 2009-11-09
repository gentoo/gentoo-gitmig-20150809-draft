# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kflickr/kflickr-0.9.1_p1.ebuild,v 1.1 2009/11/09 21:32:48 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A flickr.com image uploading program for KDE"
HOMEPAGE="http://kflickr.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="!${CATEGORY}/${PN}:0"

DOCS="AUTHORS README"
