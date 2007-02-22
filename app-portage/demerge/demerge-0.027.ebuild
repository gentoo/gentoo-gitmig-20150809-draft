# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/demerge/demerge-0.027.ebuild,v 1.1 2007/02/22 23:47:20 ian Exp $

DESCRIPTION="demerge - revert to previous installation states"
HOMEPAGE="http://download.iansview.com/gentoo/tools/demerge/"
SRC_URI="http://download.iansview.com/gentoo/tools/demerge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.03
		dev-perl/Term-ANSIColor"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin demerge || die
	dodoc Changelog
}

pkg_postinst() {
	if [ ! -e ${ROOT}/etc/portage/postsync.d/demerge-record ]; then
		mkdir -p ${ROOT}/etc/portage/postsync.d/
		echo '[ -x /usr/bin/demerge ] && /usr/bin/demerge --postsync' > ${ROOT}/etc/portage/postsync.d/demerge-record
		elog "${ROOT}/etc/portage/postsync.d/demerge-record has been installed for convenience"
		elog "If you wish for it to be automatically run at the end of every --sync simply chmod +x ${ROOT}/etc/portage/postsync.d/demerge-record"
		elog "If ever you find this to be an inconvenience simply chmod -x ${ROOT}/etc/portage/postsync.d/demerge-record"
	fi
}
