# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.6_beta.ebuild,v 1.1 2004/02/06 20:07:56 rizzo Exp $

MY_PV="${PV/_beta/beta}"
DESCRIPTION="Tkabber is a Free and Open Source client for the Jabber instant messaging system, writen in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/en/"
SRC_URI="http://www.jabberstudio.org/files/tkabber/${PN}-${MY_PV}.tar.gz"
IUSE="crypt ssl"

DEPEND=">=dev-lang/tcl-8.3*
	>=dev-lang/tk-8.3*
	dev-tcltk/tclxml-expat
	crypt? ( >=dev-tcltk/tclgpgme-1.0 )
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkTheme-1.0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
SLOT="0"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README
	dohtml README.html
}
