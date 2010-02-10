# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-lcd/gpsim-lcd-0.2.10.ebuild,v 1.2 2010/02/10 04:35:59 josejx Exp $

EAPI=2
MY_P=${PN/gpsim-}-${PV}
inherit autotools

DESCRIPTION="2x20 LCD display module for GPSIM"
HOMEPAGE="http://www.dattalo.com/gnupic/lcd.html"
SRC_URI="mirror://sourceforge/gpsim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-embedded/gpsim-0.22.0[gtk]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	docinto examples
	dodoc examples/README || die "dodoc failed"
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.{asm,inc,stc} || die "doins failed"
}
