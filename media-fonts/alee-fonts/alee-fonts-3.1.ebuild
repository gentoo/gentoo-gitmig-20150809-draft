# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/alee-fonts/alee-fonts-3.1.ebuild,v 1.6 2005/09/13 15:56:15 agriffis Exp $

inherit font

DESCRIPTION="A Lee's Hangul truetype fonts"
HOMEPAGE="http://packages.debian.org/unstable/x11/ttf-alee"

SRC_URI="mirror://debian/pool/main/t/ttf-alee/ttf-alee_${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha arm ppc ~ppc-macos s390 x86"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/ttf-alee-${PV}"

S=${FONT_S}
