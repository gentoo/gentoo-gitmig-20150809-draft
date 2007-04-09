# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.20.1.ebuild,v 1.2 2007/04/09 13:32:37 armin76 Exp $

inherit eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
MY_P="${P/-/_}"
SRC_URI="http://www.gnu.org/software/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc x86"
IUSE=""

DEPEND="virtual/libc"
S="${WORKDIR}/${MY_P}"

#src_compile() {
#	econf
#	emake CFLAGS="${CFLAGS}" || die
#}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README AUTHORS
}
