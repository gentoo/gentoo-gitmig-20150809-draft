# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.4.0.ebuild,v 1.3 2003/11/14 20:05:05 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Patch system for Gentoo sources.  Retains MD5 codes"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND=">=dev-util/xdelta-1.1.3
	>=app-arch/bzip2-1.0.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog GENTOO
	doman deltup.1
}
