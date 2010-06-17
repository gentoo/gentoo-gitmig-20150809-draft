# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-PBS/perl-PBS-0.24.ebuild,v 1.4 2010/06/17 03:29:52 jsbronder Exp $

inherit perl-module

DESCRIPTION="perl-PBS is a perl binding for the Portable Batch System client
library"
HOMEPAGE="http://www-rcf.usc.edu/~garrick/perl-PBS/"
SRC_URI="http://www-rcf.usc.edu/~garrick/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-lang/perl
		<sys-cluster/torque-2.4
		 dev-perl/Curses"
DEPEND="${RDEPEND}
		dev-lang/swig"

#src_compile() {
#	if [ "${MMSIXELEVEN}" ]; then
#		echo 'n' | perl Makefile.PL ${myconf} \
#		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
#	else
#		echo 'n' | perl Makefile.PL ${myconf} \
#		PREFIX=${D}/usr INSTALLDIRS=vendor
#	fi
#	perl-module_src_test
#}
