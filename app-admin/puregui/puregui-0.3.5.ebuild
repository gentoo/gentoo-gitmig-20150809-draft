# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puregui/puregui-0.3.5.ebuild,v 1.16 2004/03/12 10:45:39 mr_bones_ Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="mirror://sourceforge/pureftpd/${P}.tar.bz2"
HOMEPAGE="http://pureftpd.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
