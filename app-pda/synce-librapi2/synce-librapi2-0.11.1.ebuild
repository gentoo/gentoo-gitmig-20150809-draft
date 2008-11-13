# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librapi2/synce-librapi2-0.11.1.ebuild,v 1.1 2008/11/13 06:15:06 mescalinum Exp $

DESCRIPTION="SynCE - RAPI communication library"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lang/python
		dev-python/pyrex
		>=dev-libs/check-0.8.2
		~app-pda/synce-libsynce-0.11.1"

SRC_URI="mirror://sourceforge/synce/librapi2-${PV}.tar.gz"
S="${WORKDIR}/librapi2-${PV}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc BUGS README README.contributing README.design TODO ChangeLog
}
