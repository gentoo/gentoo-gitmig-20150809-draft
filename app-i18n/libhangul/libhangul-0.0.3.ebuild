# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libhangul/libhangul-0.0.3.ebuild,v 1.1 2006/11/04 05:57:09 matsuu Exp $

DESCRIPTION="libhangul is a generalized and portable library for processing hangul."
HOMEPAGE="http://kldp.net/projects/hangul/"
SRC_URI="http://kldp.net/frs/download.php/3641/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
