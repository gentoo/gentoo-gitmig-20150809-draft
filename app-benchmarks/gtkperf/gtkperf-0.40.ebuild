# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/gtkperf/gtkperf-0.40.ebuild,v 1.3 2008/11/11 14:55:03 pvdabeel Exp $

EAPI="1"

MY_P="${PN}_${PV}"
DESCRIPTION="Application designed to test GTK+ performance"
HOMEPAGE="http://gtkperf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/pkgconfig-0.9"

S="${WORKDIR}/${PN}"

src_compile() {
	econf "$(use_enable nls)"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}/usr/doc"
	dodoc AUTHORS ChangeLog README TODO
}
