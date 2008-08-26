# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/droid/droid-1.ebuild,v 1.3 2008/08/26 21:05:42 pva Exp $

inherit font

DESCRIPTION="Font family from Google's Android project"
HOMEPAGE="http://damieng.com/blog/2007/11/14/droid-font-family-courtesy-of-google-ascender"
SRC_URI="http://download.damieng.com/fonts/redistributed/DroidFamily.zip"
LICENSE="Apache-2.0"
RESTRICT="mirror" # redistributed without license
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
