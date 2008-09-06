# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.10.ebuild,v 1.7 2008/09/06 21:16:33 halcy0n Exp $

IUSE=""

MY_P=${P/q/Q}
MY_P=${MY_P/l/L}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A comprehensive software framework for quantitative finance"
HOMEPAGE="http://www.quantlib.org"
SRC_URI="mirror://sourceforge/quantlib/${MY_P}.tar.gz"

RDEPEND="dev-libs/boost"
DEPEND="sys-devel/libtool
	${RDEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha ~amd64 ppc sparc x86"

src_install(){
	einstall || die "einstall failed"
	dodoc *.txt
}
