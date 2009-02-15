# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs4-acl-tools/nfs4-acl-tools-0.3.3.ebuild,v 1.1 2009/02/15 20:55:31 vapier Exp $

DESCRIPTION="Commandline and GUI tools that deal directly with NFSv4 ACLs"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/attr"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG INSTALL README TODO
}
