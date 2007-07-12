# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-protocols/l7-protocols-2007.05.09.ebuild,v 1.2 2007/07/12 02:52:15 mr_bones_ Exp $

inherit fixheadtails toolchain-funcs

IUSE=""

MY_P=${PN}-${PV//./-}

DESCRIPTION="Protocol definitions of l7-filter kernel modules"
HOMEPAGE="http://l7-filter.sourceforge.net/protocols"

SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i -e "s/gcc.*\-o/$(tc-getCC) ${CFLAGS} -o/g" \
		-e "s/g++.*\-o/$(tc-getCXX) ${CXXFLAGS} -o/g" "${S}"/testing/Makefile
	htfix_file "${S}"/testing/*.sh
}

src_compile() {
	emake -C testing
}

# NOTE Testing mechanism is currently broken:
#  stack smashing attack in function main()

# Is also extraordinarly inefficent getting random data.
#
#src_test() {
#	cd testing
#	find ${S} -name \*.pat -print -exec ./test_match.sh {} \; \
#		-exec ./timeit.sh {} \; || die "failed tests"
#	einfo "patterns past testing"
#}

src_install() {

	dodir /usr/share/${PN}
	cd testing
	cp -pPR randprintable randchars test_speed match README *.sh ${D}/usr/share/${PN}
	cd ${S}

	dodoc README CHANGELOG HOWTO WANTED
	dodoc README.weakpatterns
	newdoc extra/README README.extra
	newdoc file_types/README README.file_types
	newdoc malware/README README.malware
	newdoc testing/README README.testing
	rm -rf README CHANGELOG HOWTO LICENSE WANTED */README testing

	make PREFIX=${D} install || die
	rm ${D}/etc/${PN}/Makefile
	chown -R root:0 ${D}
}
