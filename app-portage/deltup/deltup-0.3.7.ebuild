# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.3.7.ebuild,v 1.4 2004/01/24 00:58:27 ferringb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Patch system for Gentoo sources.  Retains MD5 codes"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/deltup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-util/xdelta-1.1.3
	>=app-arch/bzip2-1.0.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog GENTOO
	doman deltup.1
}
