# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/roboto/roboto-20111129.ebuild,v 1.1 2012/07/25 09:41:44 yngwin Exp $

inherit font

MY_PN="Roboto_Hinted_${PV}"

DESCRIPTION="Standard font for Android 4.0 (Ice Cream Sandwich) and later"
HOMEPAGE="http://developer.android.com/design/style/typography.html"
SRC_URI="https://dl-ssl.google.com/android/design/${MY_PN}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
