# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/fidelio/fidelio-1.0_beta1.ebuild,v 1.3 2003/09/07 00:17:34 msterret Exp $

IUSE="nls esd"
S=${WORKDIR}/${P/_beta1/b1}
DESCRIPTION="Fidelio is a Linux/Unix client for Hotline, a proprietary protocol that combines ftp-like, irc-like and news-like functions with user authentication and permissions in one package."
SRC_URI="mirror://sourceforge/fidelio/${P/_beta1/b1}.tar.gz"
HOMEPAGE="http://fidelio.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.2
	>=dev-libs/libxml2-2.4.12
	nls? ( sys-devel/gettext )
	esd? ( >=media-sound/esound-0.2.23 )"

src_compile() {
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libxml2/libxml"
	export CPPFLAGS="-I/usr/include/libxml2"
	export XML_CONFIG="/usr/bin/xml2-config"

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die

}

src_install () {

	einstall || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
