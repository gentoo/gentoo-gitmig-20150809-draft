# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/edox-data/edox-data-0.16.7_pre3.ebuild,v 1.10 2005/03/30 16:45:51 hansmi Exp $

inherit eutils

EVER="${PV/_pre*}"
EDOXVER="${EVER}-0.03"
DESCRIPTION="The Enlightenment online help"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-docs-${EDOXVER}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=x11-wm/enlightenment-0.16.7_pre3"

S=${WORKDIR}/enlightenment-docs-${EVER}

src_compile() {
	econf --enable-fsstd || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
