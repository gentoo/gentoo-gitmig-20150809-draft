# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-protocols/l7-protocols-2008.04.23.ebuild,v 1.1 2008/05/03 09:26:53 dragonheart Exp $

inherit eutils fixheadtails toolchain-funcs

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

	cd "${S}"
	sed -i -e "s/gcc.*\-o/$(tc-getCC) ${CFLAGS} -o/g" \
		-e "s/g++.*\-o/$(tc-getCXX) ${CXXFLAGS} -o/g" testing/Makefile
	ht_fix_file testing/*.sh
}

src_compile() {
	emake -C testing || die
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
	pushd testing > /dev/null
	cp -pPR randprintable randchars test_speed-{kernel,userspace} README \
		match_kernel speeds-2007-10-02-450MHz *.sh data "${D}"/usr/share/${PN}
	popd > /dev/null
	mv example_traffic "${D}"/usr/share/${PN}

	dodoc README CHANGELOG HOWTO WANTED
	for dir in extra file_types malware ; do
		newdoc ${dir}/README README.${dir}
	done
	rm -rf README CHANGELOG HOWTO LICENSE Makefile WANTED */README testing

	dodir /etc/l7-protocols
	cp -R * "${D}"/etc/l7-protocols
	chown -R root:0 "${D}"
}
