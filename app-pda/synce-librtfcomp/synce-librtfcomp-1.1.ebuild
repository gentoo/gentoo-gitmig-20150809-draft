# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-librtfcomp/synce-librtfcomp-1.1.ebuild,v 1.1 2008/11/13 00:13:30 mescalinum Exp $

DESCRIPTION="SynCE - Compressed RTF extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-lang/python
		dev-python/pyrex"

MY_P="librtfcomp-${PV}"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

src_install() {
	einstall || die
	mv "${D}"/usr/bin/test "${D}"/usr/bin/testrtf
}
