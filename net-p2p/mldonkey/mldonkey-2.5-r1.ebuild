# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.5-r1.ebuild,v 1.1 2003/06/02 18:51:41 caleb Exp $

IUSE="gtk"

S="${WORKDIR}/${PN}"
MY_PV="2.5"
MY_PR="0"

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://www.nongnu.org/mldonkey/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/release-${MY_PV}/official/${PN}-${MY_PV}-${MY_PR}.sources.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="gtk? ( >=lablgtk-1.2.4 )
	>=dev-lang/ocaml-3.06
	dev-lang/perl"

src_compile() {
	use gtk || export GTK_CONFIG="no"

	# the dirs are not (yet) used, but it doesn't hurt to specify them anyway
	econf \
		--sysconfdir=/etc/mldonkey \
		--sharedstatedir=/var/mldonkey \
		--localstatedir=/var/mldonkey \
		--enable-ocamlver=3.06

	emake || die
}

src_install() {
	dobin mlnet
	use gtk && dobin mlchat mlgui mlguistarter mlim mlnet+gui
	dobin ${FILESDIR}/mldonkey

	dodoc Developers.txt
	
	cd ${S}/distrib
	dodoc AUTHORS BUGS COPYING ChangeLog ed2k_links.txt TODO
	dohtml FAQ.html

	insinto /usr/share/doc/${PF}/scripts
	doins kill_mldonkey mldonkey_command mldonkey_previewer;

	insinto /usr/share/doc/${PF}/distrib
	doins directconnect.ini;

	cd ${S}/docs/users
	dodoc *

	cd ${S}/docs/developers
	dodoc *.txt *.tex

	cd ${S}/docs/networks
	dodoc *.txt *.pdf
	dohtml *.html
	
	docinto Gnutella
	dodoc Gnutella/*

	insinto /usr/share/doc/${PF}/html/images
	doins images/*
}

pkg_postinst() {
	einfo ""
	einfo "Running \`mldonkey' will start the server inside ~/.mldonkey/"
	einfo "If you want to start mldonkey in a particular working directory,"
	einfo "use the \`mlnet' command."
	einfo ""
}
