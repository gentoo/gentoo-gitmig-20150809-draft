# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librpcsecgss/librpcsecgss-0.15.ebuild,v 1.1 2007/09/06 17:14:23 vapier Exp $

DESCRIPTION="implementation of rpcsec_gss (RFC 2203) for secure rpc communication"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="net-libs/libgssglue"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:GSSAPI_CFLAGS:GSSGLUE_CFLAGS:' src/Makefile.in
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
