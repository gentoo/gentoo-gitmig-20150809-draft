# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-no/ispell-no-2.10.ebuild,v 1.6 2009/12/25 14:47:01 flameeyes Exp $

inherit multilib versionator

MY_PN=spell-norwegian
DESCRIPTION="A Norwegian dictionary for ispell"
HOMEPAGE="http://spell-norwegian.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/frs/download.php/2359/${MY_PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="app-text/ispell"

S=${WORKDIR}/${MY_PN}-$(get_major_version).0.$(get_version_component_range 2)

src_compile() {
	export LC_ALL=C #227055
	# bug #295830
	emake -j1 SED="sed" BUILDHASH="/usr/bin/buildhash" ispell || die
}

src_install () {
		insinto /usr/$(get_libdir)/ispell
		doins {nb,nn}.{hash,aff} || die
		dodoc NEWS
}
