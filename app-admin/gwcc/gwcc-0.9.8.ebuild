# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.8.ebuild,v 1.4 2005/09/19 01:23:02 dang Exp $

inherit eutils

DESCRIPTION="GNOME Workstation Command Center"
HOMEPAGE="http://gwcc.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwcc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"
RDEPEND="nls? ( sys-devel/gettext )
	sys-apps/net-tools"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-errno.patch
}

src_compile() {
	local myconf

	#sandbox fix, always disable nls
	myconf="--disable-nls"
	#use nls || myconf="--disable-nls"

	econf ${myconf} || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog NEWS README
}
