# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nfsidmap/nfsidmap-0.9.ebuild,v 1.1 2005/02/04 23:32:05 agriffis Exp $

inherit eutils flag-o-matic

DESCRIPTION="NFSv4 ID <-> name mapping library"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="ldap"

DEPEND="ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}
	!net-fs/idmapd"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/0.7-optional-ldap.patch

	use ldap \
		&& append-flags -DENABLE_LDAP \
		|| sed -i '/^LIBS/s:-lldap::' Makefile.in
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
