# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/conkeror/conkeror-0.9.3-r1.ebuild,v 1.2 2011/04/05 07:38:47 angelos Exp $

EAPI=3

inherit eutils fdo-mime

DESCRIPTION="A Mozilla-based web browser whose design is inspired by GNU Emacs"
HOMEPAGE="http://conkeror.org/"
# snapshot from http://repo.or.cz/w/conkeror.git
# conkeror.png is derived from http://commons.wikimedia.org/wiki/File:Conker.jpg
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gentoo/conkeror.png"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND=">=net-libs/xulrunner-1.9"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${P}.tar.gz
	cp "${DISTDIR}/conkeror.png" . || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	insinto /usr/lib/${PN}
	doins -r branding chrome components content defaults help locale modules \
		search-engines style tests || die
	doins application.ini chrome.manifest Info.plist || die

	exeinto /usr/lib/${PN}
	doexe conkeror-spawn-helper || die
	exeinto /usr/lib/${PN}/contrib
	doexe contrib/run-conkeror || die
	dosym /usr/lib/${PN}/contrib/run-conkeror /usr/bin/conkeror || die
	domenu "${FILESDIR}/conkeror.desktop" || die
	doicon "${WORKDIR}/conkeror.png" || die

	doman contrib/man/conkeror.1 || die
	dodoc CREDITS || die
	# Use the XULRunner found in the Prefix, not the system's one
	sed -e "s:/etc/gre.d:\"${EPREFIX}/etc/gre.d\":g" -i "${ED}"/usr/lib/conkeror/contrib/run-conkeror || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
