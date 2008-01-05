# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-lcd/gpsim-lcd-0.2.9.ebuild,v 1.4 2008/01/05 10:17:03 calchan Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils autotools

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2x20 LCD display module for GPSIM"
HOMEPAGE="http://www.dattalo.com/gnupic/lcd.html"
SRC_URI="mirror://sourceforge/gpsim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE=""

DEPEND=">=dev-embedded/gpsim-0.22.0
	=x11-libs/gtk+-2*"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	built_with_use dev-embedded/gpsim gtk || die "dev-embedded/gpsim must be built with USE=gtk"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL README
	cp -pPR "${S}"/examples "${D}"/usr/share/doc/${PF}
	find "${D}"/usr/share/doc/${PF} -name 'Makefile*' -exec rm -f \{} \;
	chmod -R 644 "${D}"/usr/share/doc/${PF}
	chmod 755 "${D}"/usr/share/doc/${PF}/examples
}
