# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/globespan-adsl/globespan-adsl-0.8-r1.ebuild,v 1.3 2004/03/19 11:31:23 lanius Exp $

IUSE="tcltk"

MY_PN="eciadsl-usermode-0.8"
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Driver for various ADSL modems based on GlobeSpan chips"
SRC_URI="http://eciadsl.flashtux.org/download/${MY_PN}.tar.bz2"
HOMEPAGE="http://eciadsl.flashtux.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=net-dialup/ppp-2.4.1"

RDEPEND="${DEPEND}
	tcltk? ( >=dev-lang/tk-8.3.4 )"

src_compile() {
	# no econf because --host is not supported
	./configure --prefix=/usr || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	make ROOT=${D} install || die "Install failed"
}
pkg_postinst() {
	einfo ""

	use tcltk && {
		einfo "Package succesfully installed you should now run 'eciconf.sh'"
		einfo "Paquetage installé avec succes vous devriez maintenant executer 'eciconf.sh'"
	}

	use tcltk || {
		einfo "Package succesfully installed you should now run 'eciconftxt.sh'"
		einfo "Paquetage installé avec succes vous devriez maintenant executer 'eciconftxt.sh'"
	}

	einfo ""
}
