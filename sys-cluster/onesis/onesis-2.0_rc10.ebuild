# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/onesis/onesis-2.0_rc10.ebuild,v 1.2 2005/07/29 01:03:28 swegener Exp $

MY_P="oneSIS-${PV/_}"

DESCRIPTION="Diskless computing made easy"
HOMEPAGE="http://onesis.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~sparc ~ppc ~ppc64"
IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}"/${MY_P}

src_install() {
	make prefix="${D}" install || die "make install failed"
}
