# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-protocols/l7-protocols-2004.09.13.ebuild,v 1.1 2004/09/19 00:20:59 dragonheart Exp $

IUSE=""

MY_P=${PN}-${PV//./_}

DESCRIPTION="Protocol definitions of l7-filter kernel modules"
HOMEPAGE="http://l7-filter.sourceforge.net/protocols"

SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
S=${WORKDIR}/${MY_P}

RDEPEND="net-misc/l7-filter"


src_compile() {
	sed -i -e 's/gcc.*-O2/${CC} ${CFLAGS}/g' testing/Makefile
	sed -i -e 's/-1/-n 1/g' testing/*.sh
	emake -C testing
}

# NOTE Testing mechanism is currently broken - it doesn't stop until it fails
# This is bad when it works.

#src_test() {
#	cd testing
#	find ${S} -name \*.pat -print -exec ./test_match.sh {} \; \
#		-exec ./timeit.sh {} \; || die "failed tests"
#	einfo "patterns past testing"
#}

src_install() {

	dodir /usr/share/${PN}
	cd testing
	cp -a randprintable randchars test_speed match README *.sh ${D}/usr/share/${PN}
	cd ${S}

	dodoc README CHANGELOG HOWTO WANTED
	docinto weakpatterns/README README.weakpatterns
	docinto extra/README README.extra
	docinto file_types/README README.file_types
	docinto malware/README README.malware
	docinto testing/README README.testing

	rm -rf README CHANGELOG HOWTO LICENSE WANTED */README testing

	make PREFIX=${D} install || die
	rm ${D}/etc/${PN}/Makefile
}
