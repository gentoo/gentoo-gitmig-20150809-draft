# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/globespan-adsl/globespan-adsl-0.11.ebuild,v 1.3 2006/10/23 07:53:06 mrness Exp $

MY_PN="eciadsl-usermode-${PV}"

DESCRIPTION="Driver for various ADSL modems. Also known as EciAdsl."
SRC_URI="http://eciadsl.flashtux.org/download/${MY_PN}.tar.gz"
HOMEPAGE="http://eciadsl.flashtux.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"

DEPEND="net-dialup/ppp"
RDEPEND="${DEPEND}
	tk? ( >=dev-lang/tk-8.3.4 )"

S="${WORKDIR}/${MY_PN}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README* TROUBLESHOOTING* ChangeLog || die "failed to install documentation"
}

pkg_postinst() {
	einfo
	einfo "Package succesfully installed you should now run "
	einfo "eciconf.sh (graphical, requires TCL/TK) or eciconftxt.sh"
	einfo
	einfo "Paquetage installé avec succés vous devriez maintenant"
	einfo "executer eciconf.sh (qui requiert TCL/TK) ou eciconftxt.sh"
	einfo
	ewarn "Please note that if you're using a 2.6.x kernel you'll"
	ewarn "probably need to apply a patch to fix a USB bug. See"
	ewarn "http://eciadsl.flashtux.org/download/beta/"
	einfo
}
