# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.14_rc1.ebuild,v 1.5 2003/09/07 00:12:23 msterret Exp $

IUSE="nls gtk2"
P=${PN}-${PV/_/}
S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/x11
	gtk2? ( >=x11-libs/gtk+-2.0.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	# do not use enable-{gtk20,gtkport} they are not recognized
	# and will disable building the gtkport alltogether
	use gtk2 \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --disable-gtk20"

	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die

	dodoc COPYING ChangeLog AUTHORS README* THANKS \
		TODO docs/USERS-GUIDE NEWS

}
