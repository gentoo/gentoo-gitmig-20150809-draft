# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/babygimp/babygimp-0.41.ebuild,v 1.2 2003/02/13 12:30:19 vapier Exp $

DESCRIPTION="Icon editor written in Perl/TK"
HOMEPAGE="http://babygimp.sourceforge.net/"
SRC_URI="mirror://sourceforge/babygimp/${PN}_${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
DEPEND="dev-perl/perl-tk"
S="${WORKDIR}/${PN}_${PV}"

src_install() {
	dobin babygimp
	dodoc README.babygimp
}
