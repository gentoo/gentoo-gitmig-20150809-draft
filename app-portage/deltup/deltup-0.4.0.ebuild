# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.4.0.ebuild,v 1.8 2004/07/14 01:44:32 agriffis Exp $

DESCRIPTION="Patch system for Gentoo sources.  Retains MD5 codes"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-util/xdelta-1.1.3
	>=app-arch/bzip2-1.0.0"

pkg_setup() {
	echo
	einfo ""
	einfo "Please note that deltup will be removed from portage "
	einfo "in the near future.  Development on deltup has stopped, although "
	einfo "patches are being generated in the interim until another distfile "
	einfo "patching system is ready for testing."
	einfo ""
	einfo "further info will be available at "
	einfo "http://www.gentoo.org/proj/en/glep/glep-0009.html"
	einfo ""
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 3
}
src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog GENTOO
	doman deltup.1
}
