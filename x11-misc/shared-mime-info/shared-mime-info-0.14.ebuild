# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shared-mime-info/shared-mime-info-0.14.ebuild,v 1.1 2004/03/24 14:49:25 foser Exp $

DESCRIPTION="The Shared MIME-info Database specification."

HOMEPAGE="http://www.freedesktop.org/software/shared-mime-info"
SRC_URI="http://www.freedesktop.org/software/shared-mime-info/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~amd64 ~ia64"
USE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	einstall || die

	dodoc COPYING ChangeLog NEWS README

}
