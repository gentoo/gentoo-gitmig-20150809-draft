# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.0.ebuild,v 1.6 2004/02/22 20:11:11 agriffis Exp $

IUSE=""

MY_P=${P/q/Q}
MY_P=${MY_P/l/L}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A comprehensive software framework for quantitative finance"
HOMEPAGE="http://www.quantlib.org"
SRC_URI="mirror://sourceforge/quantlib/${MY_P}-src.tar.gz"

DEPEND="sys-devel/libtool"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

src_install(){
	einstall || die "einstall failed"
	dodoc *.txt
}
