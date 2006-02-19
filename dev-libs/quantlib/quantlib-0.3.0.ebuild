# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.0.ebuild,v 1.11 2006/02/19 19:32:45 kumba Exp $

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
KEYWORDS="alpha ~hppa ppc ~sparc x86"

src_install(){
	einstall || die "einstall failed"
	dodoc *.txt
}
