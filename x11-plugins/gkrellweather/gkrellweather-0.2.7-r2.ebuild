# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellweather/gkrellweather-0.2.7-r2.ebuild,v 1.11 2004/01/04 18:36:48 aliz Exp $

S=${WORKDIR}/${P}
DEBPATCH=${PN}_${PV}-1.diff.gz
DESCRIPTION="GKrellM Plugin that monitors a METAR station and displays weather
info"
SRC_URI="http://www.cse.unsw.edu.au/~flam/repository/c/gkrellm/${P}.tar.gz
	mirror://debian/pool/main/g/gkrellweather/${DEBPATCH}"
HOMEPAGE="http://www.cse.unsw.edu.au/~flam/programs/gkrellweather.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="=app-admin/gkrellm-1.2*
	>=net-misc/wget-1.5.3"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1"

src_unpack() {
	unpack ${P}.tar.gz
	zcat ${DISTDIR}/${DEBPATCH} | patch -d ${P} -p1
}

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
