# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.60.ebuild,v 1.1 2003/04/05 21:46:14 sethbc Exp $

IUSE="nls perl spell"

DESCRIPTION="GTK Instant Messenger client - CVS ebuild."
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/sourceforge/gaim/gaim-0.60.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND="=sys-libs/db-1*
	!net-im/gaim
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=media-libs/audiofile-0.2.0
	media-libs/libao
	sys-devel/gettext
	perl? ( >=dev-lang/perl-5.6.1 )
	spell? ( >=app-text/gtkspell-2.0.2 )"

src_compile() {
	local myconf="--prefix=/usr"

	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"

	use nls  || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO ChangeLog
}
