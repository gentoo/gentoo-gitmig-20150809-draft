# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnugadu/gnugadu-2.2.0.ebuild,v 1.2 2004/10/21 20:31:18 spock Exp $

IUSE="debug tlen esd oss xosd arts jabber perl spell"

inherit eutils

MY_P="gg2-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="GTK-based Gadu-Gadu, Tlen and Jabber IM client"
SRC_URI="mirror://sourceforge/ggadu/${MY_P}.tar.gz"
HOMEPAGE="http://gadu.gnu.pl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/gtk+-2.4.0
	sys-devel/gettext
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4
	jabber? ( >=net-libs/loudmouth-0.17 )
	xosd? ( x11-libs/xosd )
	perl? ( dev-lang/perl dev-perl/XML-Parser )
	arts? ( >=kde-base/arts-0.9.5 )
	esd? ( media-sound/esound )
	tlen? ( net-libs/libtlen )
	spell? ( app-text/gtkspell )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -re 's#GTKSPELL_LIBS=`(.*)`#GTKSPELL_LIBS="`\1` -laspell"#g' -i configure
}

src_compile() {

	myconf="--with-gui --with-gadu --with-remote --with-docklet_system_tray --with-docklet_dockapp \
		--with-sms --with-update --with-external --with-gghist --with-history-external-viewer"

	if use arts; then
		myconf="${myconf} --with-arts --with-arts-prefix=`artsc-config --arts-prefix`"
	fi

	econf ${myconf} \
		`use_enable debug` \
		`use_with oss` \
		`use_with esd` \
		`use_with xosd` \
		`use_with arts` \
		`use_with perl` \
		`use_with tlen` \
		`use_with jabber` \
		`use_with spell gtkspell` || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

