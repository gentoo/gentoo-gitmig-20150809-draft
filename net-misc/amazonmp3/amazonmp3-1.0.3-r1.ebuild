# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/amazonmp3/amazonmp3-1.0.3-r1.ebuild,v 1.1 2008/09/29 14:20:06 lack Exp $

EAPI="1"

inherit rpm fdo-mime

DESCRIPTION="AmazonMp3 is a download manager which interfaces with the http://mp3.amazon.com music store"
HOMEPAGE="http://www.amazon.com/gp/dmusic/help/amd.html/"
SRC_URI="amazonmp3.rpm"
RESTRICT="fetch strip"

LICENSE="amazonmp3"
SLOT="0"
# AMD64 support requires more magic in amazonmp3-libcompat ebuild that isn't
# ready yet.
KEYWORDS="~x86 -amd64 -*"
IUSE=""

RDEPEND="=net-misc/amazonmp3-libcompat-0.1"
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

src_install() {
	dobin bin/amazonmp3 || die "dobin failed"

	insinto "/usr/share"
	doins -r share/{applications,pixmaps,mime,mime-info,mimelnk} || die "doins failed"

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
