# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/transset/transset-0.1_pre20040821.ebuild,v 1.5 2004/09/09 19:05:04 pauldv Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Set the transparency levels of windows in an X11 environment"
HOMEPAGE="http://xorg.freedesktop.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=x11-base/xorg-x11-6.7.99.902"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	dobin transset
	dodoc ChangeLog
}
