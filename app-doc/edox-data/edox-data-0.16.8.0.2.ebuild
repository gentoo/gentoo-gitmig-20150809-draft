# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/edox-data/edox-data-0.16.8.0.2.ebuild,v 1.4 2011/12/14 09:23:58 phajdan.jr Exp $

inherit eutils

MY_P="e16-docs-${PV}"
DESCRIPTION="The Enlightenment online help"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=x11-wm/enlightenment-0.16.8"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --enable-fsstd || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README
}
