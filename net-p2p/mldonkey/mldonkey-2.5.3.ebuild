# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.5.3.ebuild,v 1.1 2003/06/17 13:12:43 caleb Exp $

IUSE="gtk"

MY_PV=${PV%.*}-${PV#*.*.}
MY_P=${PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://www.nongnu.org/mldonkey/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/release-${MY_PV}/official/${MY_P}.sources.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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

	cd ${S}/distrib
	dodoc AUTHORS BUGS COPYING ChangeLog ed2k_links.txt INSTALL TODO
	dohtml FAQ.html

	insinto /usr/share/doc/${PF}/scripts
	doins kill_mldonkey mldonkey_command mldonkey_previewer

	insinto /usr/share/doc/${PF}/distrib
	doins directconnect.ini servers.ini

	cd ${S}/docs
	dodoc *.txt *.tex
	dohtml *.html

	cd ${S}/docs/developers
	dodoc *.txt *.tex

	cd ${S}/docs/images
	insinto /usr/share/doc/${PF}/html/images
	doins *
}

pkg_postinst() {
	echo
	einfo "Running \`mldonkey' will start the server inside ~/.mldonkey/"
	einfo "If you want to start mldonkey in a particular working directory,"
	einfo "use the \`mlnet' command."
	echo
}
