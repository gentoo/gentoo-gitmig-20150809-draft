# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libhangul/libhangul-0.0.6.ebuild,v 1.2 2007/08/10 22:29:47 matsuu Exp $

DESCRIPTION="libhangul is a generalized and portable library for processing hangul."
HOMEPAGE="http://kldp.net/projects/hangul/"
SRC_URI="http://kldp.net/frs/download.php/3973/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README
}
