# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/synce-libsynce-0.13.ebuild,v 1.1 2009/01/21 00:19:35 mescalinum Exp $

DESCRIPTION="SynCE - common library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="hal"
DEPEND=">=dev-libs/check-0.8.3.1"
RDEPEND="${DEPEND}"

SRC_URI="mirror://sourceforge/synce/libsynce-${PV}.tar.gz"
S="${WORKDIR}/libsynce-${PV}"

src_compile() {
	econf $(use_enable hal hal-support) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO ChangeLog
}
