# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Scan/Audio-Scan-0.70.ebuild,v 1.1 2010/03/24 08:17:55 tove Exp $

EAPI=2

MODULE_AUTHOR=AGRUNDMA
inherit perl-module

DESCRIPTION="XS parser for MP3, MP4, Ogg Vorbis, FLAC, ASF, WAV, AIFF, Musepack, Monkey's Audio"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
