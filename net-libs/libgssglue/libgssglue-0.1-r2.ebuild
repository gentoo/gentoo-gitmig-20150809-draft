# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgssglue/libgssglue-0.1-r2.ebuild,v 1.1 2010/07/27 10:01:12 flameeyes Exp $

EAPI=2

DESCRIPTION="exports a gssapi interface which calls other random gssapi libraries"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="!app-crypt/libgssapi"

src_configure() {
	# No need to install static libraries, as it uses libdl
	econf --disable-static
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${D}" -name '*.la' -delete || die

	dodoc AUTHORS ChangeLog NEWS README

	insinto /etc
	doins doc/gssapi_mech.conf || die
}
