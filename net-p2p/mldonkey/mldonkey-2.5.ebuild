# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.5.ebuild,v 1.1 2003/05/28 13:59:57 caleb Exp $

IUSE="gtk"

S="${WORKDIR}/${PN}"
MY_PV=${PV}-0

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://savannah.nongnu.org/projects/mldonkey/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/release-${PV}/official/${PN}-${MY_PV}.sources.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="gtk? ( >=lablgtk-1.2.3 )
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
	dobin mldonkey mlchat mldc mlgnut mlgui mlguistarter mlim mlnap mlnet \
	mlslsk use_tags	mldonkey_gui mldonkey+gui mldonkey_gui2 \
	mldonkey_guistarter mlgnu+gui mlnet+gui mlslsk+gui mlnap+gui \
	mlgnut+gui mldc+gui

	cd docs
	dodoc *.txt *.pdf *tex
	dohtml *.html
	insinto /usr/share/doc/${PF}/images
	doins images/*
	
	cd ${S}/distrib
	dodoc AUTHORS BUGS COPYING ChangeLog Developers.txt ed2k_links.txt \
		Readme.txt TODO 
	dohtml FAQ.html
	
	insinto /usr/share/doc/${PF}/scripts
	doins kill_mldonkey mldonkey_command mldonkey_previewer;

	insinto /usr/share/doc/${PF}/distrib
	doins directconnect.ini;

	
}

pkg_postinst() {
	einfo "To start mldonkey, copy the contents of \$doc/distrib in a"
	einfo "writable directory, and start mldonkey from there."
	einfo "Eg: cp everything to /home/user1/mldonkey"
	einfo "then: cd /home/user1/mldonkey && mldonkey >> mld.log &"
}
