# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gezel/gezel-1.7.ebuild,v 1.2 2005/06/26 09:21:28 dholm Exp $

DESCRIPTION="GEZEL is a language and open environment for exploration, simulation and implementation of domain-specific micro-architectures."
HOMEPAGE="http://www.ee.ucla.edu/~schaum/gezel/"
SRC_URI="http://www.ee.ucla.edu/~schaum/gezel/package/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="java"

RDEPEND="dev-libs/gmp
	virtual/libc"

#	systemc not tested - couldn't be bothered understanding their license.
#	systemc? ( sci-electronics/systemc )"

DEPEND="sys-apps/gawk
	sys-devel/bison
	${RDEPEND}
	java? ( virtual/jdk dev-java/java-config )"

src_compile() {
	econf  --enable-gezel51 $(use_enable java)|| die 'configure failed'

	# other config options failing for various reasons - Assumed to be systemc missing dependancy.

	#--enable-gplatform need armsim

	emake JAVAC=$(java-config -c) JAVAH=javah INCLUDES="-I${S}/gezel -I$(java-config -O)/include -I$(java-config -O)/include/linux" || die 'compile failed'

}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README TODO doc/*.*
	docinto umlistings
	dodoc doc/umlistings/*
}
