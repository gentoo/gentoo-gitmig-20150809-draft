# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-es/ispell-es-1.11.ebuild,v 1.1 2012/04/07 06:58:18 scarabeus Exp $

EAPI=4

MY_P="espa~nol-${PV}"

inherit multilib

DESCRIPTION="A Spanish dictionary for ispell"
SRC_URI="http://www.datsi.fi.upm.es/~coes/${MY_P}.tar.gz"
HOMEPAGE="http://www.datsi.fi.upm.es/~coes/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

RDEPEND="app-text/ispell"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins espa~nol.aff espa~nol.hash
	dodoc LEAME README
}
