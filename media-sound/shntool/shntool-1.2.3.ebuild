# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shntool/shntool-1.2.3.ebuild,v 1.1 2003/04/12 08:25:42 jje Exp $

DESCRIPTION="shntool is a multi-purpose WAVE data processing and reporting utility"
HOMEPAGE="http://shnutils.freeshell.org/shntool/"
SRC_URI="http://shnutils.freeshell.org/shntool/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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

