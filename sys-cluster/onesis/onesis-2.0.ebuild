# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/onesis/onesis-2.0.ebuild,v 1.1 2008/08/30 04:46:12 dberkholz Exp $

MY_P="oneSIS-${PV/_}"

DESCRIPTION="Diskless computing made easy"
HOMEPAGE="http://onesis.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}"/${MY_P}

src_install() {
	make prefix="${D}" install || die "make install failed"
}
