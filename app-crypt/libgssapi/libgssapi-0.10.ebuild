# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/libgssapi/libgssapi-0.10.ebuild,v 1.4 2006/10/23 22:26:23 vapier Exp $

inherit eutils

DESCRIPTION="a gssapi interface wrapper"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/libgssapi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
	insinto /etc
	doins doc/gssapi_mech.conf || die
}
