# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shntool/shntool-1.2.3.ebuild,v 1.5 2004/02/15 14:52:45 dholm Exp $

DESCRIPTION="shntool is a multi-purpose WAVE data processing and reporting utility"
HOMEPAGE="http://shnutils.freeshell.org/shntool/"
SRC_URI="http://shnutils.freeshell.org/shntool/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=media-sound/shorten-3.5.1
	>=media-libs/flac-1.1.0 "

S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc doc/*
}

