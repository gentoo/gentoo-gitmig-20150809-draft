# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellweather/gkrellweather-0.2.7-r1.ebuild,v 1.7 2003/06/12 22:25:36 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GKrellM Plugin that monitors a METAR station and displays weather
info"
SRC_URI="http://www.cse.unsw.edu.au/~flam/repository/c/gkrellm/${P}.tar.gz"
HOMEPAGE="http://www.cse.unsw.edu.au/~flam/programs/gkrellweather.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=app-admin/gkrellm-1.2*
	>=net-misc/wget-1.5.3"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/share/gkrellm
	doexe GrabWeather 

	insinto /usr/lib/gkrellm/plugins
	doins gkrellweather.so
	dodoc README ChangeLog COPYING
}
