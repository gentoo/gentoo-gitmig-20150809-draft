# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/onesis/onesis-2.0_rc10.ebuild,v 1.1 2005/07/28 22:20:22 tantive Exp $

DESCRIPTION="Diskless computing made easy"
HOMEPAGE="http://onesis.org/"
SRC_URI="mirror://sourceforge/onesis/${PN/sis/SIS}-${PV/_rc/rc}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~sparc ~ppc ~ppc64"
IUSE=""

DEPEND="perl"

src_unpack() {
	unpack ${A}
}

src_compile() {
	myS=`echo ${S} |sed -e "s|\(/work/.*\)_rc|\1rc|" -e "s|\(/work/.*\)sis|\1SIS|"`
	cd "${myS}"
	emake || die "emake failed"
}

src_install() {
	echo D=${D}
	pwd
	myS=`echo ${S} |sed -e "s|\(/work/.*\)_rc|\1rc|" -e "s|\(/work/.*\)sis|\1SIS|"`
	cd "${myS}"
	make prefix="${D}" install || die "make install failed"
}
