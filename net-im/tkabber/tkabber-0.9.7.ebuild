# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.7.ebuild,v 1.2 2005/04/07 14:00:20 luckyduck Exp $

DESCRIPTION="Tkabber is a Free and Open Source client for the Jabber instant messaging system, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
SRC_URI="http://www.jabberstudio.org/files/tkabber/${P}.tar.gz"
IUSE="crypt ssl"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	dev-tcltk/tclxml-expat
	crypt? ( >=dev-tcltk/tclgpgme-1.0 )
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkTheme-1.0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~amd64"
SLOT="0"

src_compile() {
	# dont run make, because the Makefile is broken with all=install
	echo -n
}

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README
	dohtml README.html
}
