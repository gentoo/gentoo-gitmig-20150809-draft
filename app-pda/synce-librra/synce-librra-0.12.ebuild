# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librra/synce-librra-0.12.ebuild,v 1.1 2008/11/13 00:11:49 mescalinum Exp $

DESCRIPTION="SynCE - RRA protocol library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lang/python
		dev-python/pyrex
		dev-libs/libmimedir
		!app-pda/synce-rra
		~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"

SRC_URI="mirror://sourceforge/synce/librra-${PV}.tar.gz"
S="${WORKDIR}/librra-${PV}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
}
