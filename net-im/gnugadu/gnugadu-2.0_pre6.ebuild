# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnugadu/gnugadu-2.0_pre6.ebuild,v 1.1 2004/02/07 11:30:46 spock Exp $

IUSE="tlen esd oss xosd arts jabber perl"

MY_P="gg2-2.0pre6"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="GTK-based Gadu-Gadu, Tlen and Jabber IM client"
SRC_URI="mirror://sourceforge/ggadu/${MY_P}.tar.bz2"
HOMEPAGE="http://gadu.gnu.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.2.0
	sys-devel/gettext
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4
	jabber? ( =net-libs/loudmouth-0.14* )
	xosd? ( x11-libs/xosd )
	perl? ( dev-lang/perl dev-perl/XML-Parser )
	>=net-im/ekg-1.4
	arts? ( >=kde-base/arts-0.9.5 )
	esd? ( media-sound/esound )
	tlen? ( net-libs/libtlen )"

src_compile() {

	myconf="--with-gui --with-gadu --with-remote --with-docklet_system_tray --with-docklet_dockapp --with-sms --with-update --with-external"

	econf ${myconf} \
		`use_with oss` \
		`use_with esd` \
		`use_with xosd` \
		`use_with arts` \
		`use_enable perl` \
		`use_with tlen` \
		`use_with jabber` || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

