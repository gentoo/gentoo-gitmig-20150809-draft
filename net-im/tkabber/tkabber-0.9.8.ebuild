# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.8.ebuild,v 1.1 2006/04/08 11:14:17 reb Exp $

inherit eutils

DESCRIPTION="Tkabber is a Free and Open Source client for the Jabber instant messaging system, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
SRC_URI="http://files.jabberstudio.org/tkabber/${P}.tar.gz"
IUSE="crypt ssl"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	|| ( >=dev-tcltk/tclxml-3.0 dev-tcltk/tclxml-expat )
	crypt? ( >=dev-tcltk/tclgpgme-1.0 )
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkTheme-1.0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~sparc ~amd64"
SLOT="0"

pkg_setup() {
	if has_version '>=dev-tcltk/tclxml-3.0' \
		&& ! built_with_use dev-tcltk/tclxml expat ; then
		eerror "tclxml is missing expat support."
		eerror "Please add 'expat' to your USE flags, and re-emerge tclxml."
		die "tclxml needs expat support"
	fi
}

src_compile() {
	# dont run make, because the Makefile is broken with all=install
	echo -n
}

src_install() {
	dodir /usr/share/tkabber
	cp -R *.tcl plugins pixmaps textundo aniemoteicons ifacetk \
	emoticons-tkabber msgs mclistbox-1.02 \
	jabberlib-tclxml sounds ${D}/usr/share/tkabber

	cat <<-EOF > tkabber
	#!/bin/sh
	exec wish /usr/share/tkabber/tkabber.tcl -name tkabber
	EOF

	chmod +x tkabber
	dobin tkabber
	dodoc AUTHORS COPYING ChangeLog INSTALL README
	dohtml README.html
	cp -R doc examples contrib ${D}/usr/share/doc/${PF}
}
