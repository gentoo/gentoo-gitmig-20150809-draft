# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.16-r1.ebuild,v 1.3 2004/02/06 16:33:38 gustavoz Exp $

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"
IUSE="nls gtk gtk2 ssl"

DEPEND="virtual/x11
	ssl? ( dev-libs/openssl )
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 ) : ( =x11-libs/gtk+-1.2* ) )
	!gtk? ( sys-libs/readline
		sys-libs/ncurses
		=dev-libs/glib-1.2* )"

#RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}

	cd ${S}/lib
	# fix problem in #34475
	epatch ${FILESDIR}/${P}-ipv6_fix.patch

}

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	# do not use enable-{gtk20,gtkport} they are not recognized
	# and will disable building the gtkport alltogether
	if [ -n "`use gtk`" ]
	then
		einfo "gtk+ enabled"
		use gtk2 \
			&& einfo "gtk2 enabled" \
			|| myconf="${myconf} --disable-gtk20"
	else
		einfo "gtk+ and gtk2 disabled"
		myconf="${myconf} --disable-gtkport --disable-gtk20"
	fi

	use ssl \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --disable-ssl"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc COPYING ChangeLog AUTHORS README* THANKS \
		TODO docs/USERS-GUIDE NEWS

}
