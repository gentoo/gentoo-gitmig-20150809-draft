# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.3b.ebuild,v 1.2 2003/02/01 02:38:01 agenkin Exp $

DESCRIPTION="Featurefull Jabber client for tcl/tk."
HOMEPAGE="http://www.jabber.ru/projects/tkabber/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	>=dev-tcltk/tls-1.4.1"

LICENSE="GPL-2"
KEYWORDS="~x86"

SLOT="0"

MY_P="$(echo ${P}|sed 's/b$/beta/')"
SRC_URI="http://www.jabber.ru/projects/tkabber/tkabber-0.9beta/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

src_compile() {

	# Nothing to compile.
	true

}

src_install() {

	make DESTDIR=${D} PREFIX=/usr install || die
	
	dodoc AUTHORS COPYING ChangeLog INSTALL README
	dohtml README.html

}
