# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.0.ebuild,v 1.3 2002/12/09 04:21:04 manson Exp $

IUSE="libtool"

Name="QuantLib"
S=${WORKDIR}/${Name}-${PV}
DESCRIPTION="A comprehensive software framework for quantitative finance"
SRC_URI="mirror://sourceforge/quantlib/${Name}-${PV}-src.tar.gz"
HOMEPAGE="www.quantlib.org"

DEPEND="libtool? ( sys-devel/libtool )"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc "

src_compile(){
	econf || die "./configure failed"
	emake || die
}
 
src_install(){
	einstall || die "einstall failed"
	dodoc Authors.txt ChangeLog.txt Contributors.txt History.txt \
		  INSTALL.txt LICENSE.txt News.txt Readme.txt TODO.txt 
}
