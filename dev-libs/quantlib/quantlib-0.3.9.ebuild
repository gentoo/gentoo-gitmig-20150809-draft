# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.9.ebuild,v 1.1 2005/05/08 20:33:02 vanquirius Exp $

IUSE=""

MY_P=${P/q/Q}
MY_P=${MY_P/l/L}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A comprehensive software framework for quantitative finance"
HOMEPAGE="http://www.quantlib.org"
SRC_URI="mirror://sourceforge/quantlib/${MY_P}.tar.gz"

DEPEND="sys-devel/libtool
	dev-libs/boost"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc"

src_install(){
	einstall || die "einstall failed"
	dodoc *.txt
}
