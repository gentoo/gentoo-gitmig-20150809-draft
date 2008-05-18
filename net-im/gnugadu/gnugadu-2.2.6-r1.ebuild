# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnugadu/gnugadu-2.2.6-r1.ebuild,v 1.6 2008/05/18 13:52:21 drac Exp $

IUSE="debug tlen esd oss xosd arts jabber perl spell gnutls"

inherit eutils

MY_P="gg2-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="GTK-based Gadu-Gadu, Tlen and Jabber IM client"
SRC_URI="mirror://sourceforge/ggadu/${MY_P}.tar.gz"
HOMEPAGE="http://gadu.gnu.pl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

RDEPEND="net-libs/libgadu
	>=x11-libs/gtk+-2.4.0
	jabber? ( >=net-libs/loudmouth-0.17 )
	xosd? ( x11-libs/xosd )
	perl? ( dev-lang/perl dev-perl/XML-Parser )
	arts? ( >=kde-base/arts-0.9.5 )
	esd? ( media-sound/esound )
	tlen? ( net-libs/libtlen )
	spell? ( app-text/gtkspell )
	gnutls? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -re 's#GTKSPELL_LIBS=`(.*)`#GTKSPELL_LIBS="`\1` -laspell"#g' -i configure
}

src_compile() {

	myconf="--with-gui --with-gadu --with-remote --with-docklet_system_tray --with-docklet_dockapp \
		--with-sms --with-update --with-external --with-gghist --with-history-external-viewer --with-external-libgadu"

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
		`use_with spell gtkspell` \
		`use_with gnutls` || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	insinto /usr/share/applications
	doins gg2.desktop
	dodoc AUTHORS ChangeLog NEWS README TODO
}
