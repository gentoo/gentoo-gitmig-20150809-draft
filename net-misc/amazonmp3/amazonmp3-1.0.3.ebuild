# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/amazonmp3/amazonmp3-1.0.3.ebuild,v 1.2 2008/09/05 14:35:38 lack Exp $

EAPI="1"

inherit rpm fdo-mime multilib

DESCRIPTION="AmazonMp3 is a download manager which interfaces with the http://mp3.amazon.com music store"
HOMEPAGE="http://www.amazon.com/gp/dmusic/help/amd.html/"
SRC_URI="amazonmp3.rpm"
RESTRICT="fetch"

LICENSE="amazonmp3"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	net-misc/curl
	dev-libs/openssl
	dev-libs/boost"
DEPEND=""

S="${WORKDIR}/usr/"

pkg_nofetch() {
	einfo "Due to licensing restrictions, you must download this software from"
	einfo "amazon.com manually:"
	einfo " - Visit ${HOMEPAGE}"
	einfo " - Agree to the Terms of Service, click the agreement box, and"
	einfo "   download the version for 'Fedora 8'.  It will be called"
	einfo "   'amazonmp3.rpm'"
	einfo " - Copy 'amazonmp3.rpm' into ${DISTDIR}"
	einfo " - Run 'ebuild amazonmp3' again."
	einfo "If the version does not match or if you get any errors about the"
	einfo "rpm you just downloaded, file a bug at http://bugs.gentoo.org, and"
	einfo "be sure to include the output of 'file amazonmp3.rpm'"
}

src_compile() {
	return
}

src_install() {
	# Their binary, compiled for Fedora 8, needs some odd library names, so we
	# symlink them:
	dosym libboost_date_time.so /usr/$(get_libdir)/libboost_date_time.so.3
	dosym libboost_iostreams.so /usr/$(get_libdir)/libboost_iostreams.so.3
	dosym libboost_signals.so /usr/$(get_libdir)/libboost_signals.so.3
	dosym libboost_thread-mt.so /usr/$(get_libdir)/libboost_thread-mt.so.3
	dosym libcrypto.so /usr/$(get_libdir)/libcrypto.so.6
	dosym libssl.so /usr/$(get_libdir)/libssl.so.6

	dobin bin/amazonmp3

	for dir in applications pixmaps mime/packages mime-info mimelnk/audio; do
		insinto "/usr/share/${dir}"
		doins "share/${dir}/"*
	done

	dodoc share/doc/amazonmp3/releasenotes
	dohtml share/doc/amazonmp3/*.html
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
