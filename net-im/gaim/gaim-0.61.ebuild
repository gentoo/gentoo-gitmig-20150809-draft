# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.61.ebuild,v 1.2 2003/04/17 17:08:58 lostlogic Exp $

IUSE="nls perl spell ssl nas"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
EV=1.18
SRC_URI="mirror://sourceforge/gaim/${P}.tar.bz2
        ssl? ( mirror://sourceforge/gaim-encryption/encrypt-${EV}.tar.gz )"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha ~sparc"

DEPEND="=sys-libs/db-1*
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	nls? ( sys-devel/gettext )
	media-libs/libao
	>=media-libs/audiofile-0.2.0
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( dev-libs/openssl )
	spell? ( >=app-text/gtkspell-2.0.2 )"

src_unpack() {
	unpack ${P}.tar.bz2
	use ssl && {
		cd ${S}/plugins
		unpack encrypt-${EV}.tar.gz
		cd encrypt
                epatch patchfile.${PV}
	}
}

src_compile() {
	local myconf
        use perl || myconf="${myconf} --disable-perl"
        use spell || myconf="${myconf} --disable-gtkspell"
        use nls  || myconf="${myconf} --disable-nls"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"

	econf ${myconf} || die "Configuration failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO ChangeLog
}
