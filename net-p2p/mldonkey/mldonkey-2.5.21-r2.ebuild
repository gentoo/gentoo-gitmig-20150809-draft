# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.5.21-r2.ebuild,v 1.10 2006/04/27 19:24:27 mattam Exp $

inherit eutils

IUSE="gtk"

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://www.nongnu.org/mldonkey/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz
	http://ftp.berlios.de/pub/mldonkey/spiralvoice/patchpacks/patch_pack21g"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~ia64 ~hppa"

RDEPEND="gtk? ( =dev-ml/lablgtk-1.2.6* )
	>=dev-lang/ocaml-3.07
	dev-lang/perl
	net-misc/wget"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

MLUSER="p2p"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	#Don't change this, unless you know what you are doing
	patch -p0 < ${DISTDIR}/patch_pack21g || die
	export WANT_AUTOCONF=2.5
	cd config; autoconf; cd ..
}


src_compile() {
	use gtk || export GTK_CONFIG="no"

	# the dirs are not (yet) used, but it doesn't hurt to specify them anyway
	econf \
		--sysconfdir=/etc/mldonkey \
		--sharedstatedir=/var/mldonkey \
		--localstatedir=/var/mldonkey \
		--enable-batch \
		--enable-checks \
		--enable-pthread || die
	export OCAMLRUNPARAM="l=256M"
	emake || die
}

src_install() {
	dobin mlnet
	use gtk && dobin mlchat mlgui mlguistarter mlim mlnet+gui
	dobin ${FILESDIR}/mldonkey

	dodoc ChangeLog Copying.txt Developers.txt Install.txt
	cd ${S}/distrib
	dodoc ChangeLog Authors.txt Bugs.txt Copying.txt Developers.txt Install.txt Readme.txt Todo.txt ed2k_links.txt
	dohtml FAQ.html

	insinto /usr/share/doc/${PF}/scripts
	doins kill_mldonkey mldonkey_command mldonkey_previewer

	insinto /usr/share/doc/${PF}/distrib
	doins directconnect.ini

	cd ${S}/docs
	dodoc *.txt *.tex *.pdf
	dohtml *.html

	cd ${S}/docs/developers
	dodoc *.txt *.tex

	cd ${S}/docs/images
	insinto /usr/share/doc/${PF}/html/images
	doins *

	insinto /etc/conf.d; newins ${FILESDIR}/mldonkey.confd mldonkey
	exeinto /etc/init.d; newexe ${FILESDIR}/mldonkey.initd mldonkey
}

pkg_preinst() {
	enewuser ${MLUSER} -1 /bin/bash /home/p2p users
}

pkg_postinst() {
	echo
	einfo "Running \`mldonkey' will start the server inside ~/.mldonkey/"
	einfo "If you want to start mldonkey in a particular working directory,"
	einfo "use the \`mlnet' command."
	einfo "If you want to start mldonkey as a system service, use"
	einfo "the /etc/init.d/mldonkey script. To control bandwidth, use"
	einfo "the 'slow' and 'fast' arguments. Be sure to have a look at"
	einfo "/etc/conf.d/mldonkey also."
	echo
}
