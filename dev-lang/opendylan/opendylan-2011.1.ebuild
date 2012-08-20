# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/opendylan/opendylan-2011.1.ebuild,v 1.1 2012/08/20 09:21:25 patrick Exp $
EAPI=4

inherit autotools

RESTRICT="test"

DESCRIPTION="OpenDylan language runtime environment"

HOMEPAGE="http://opendylan.org"
SRC_URI="https://github.com/dylan-lang/opendylan/zipball/v2011.1 -> opendylan-2011.1.zip"
MY_P="dylan-lang-opendylan-23f8ab5" # WTF github, that's NOT funny

S=${WORKDIR}/${MY_P}

LICENSE="Opendylan"
SLOT="0"

# not tested on x86
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-libs/boehm-gc
	dev-lang/perl
	dev-perl/XML-Parser
	|| ( dev-lang/opendylan-bin dev-lang/opendylan )"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir -p build-aux
	elibtoolize && eaclocal || die "Fail"
	automake --foreign --add-missing # this one dies wrongfully
	eautoconf || die "Fail"
}

src_configure() {
	if has_version =dev-lang/opendylan-bin-2011.1; then
		PATH=/opt/opendylan-2011.1/bin/:$PATH
	fi
	econf || die
}

src_compile() {
	ulimit -s 32000 # this is naughty build system
	emake || die
}

src_install() {
	ulimit -s 32000 # this is naughty build system
	# because of Makefile weirdness it rebuilds quite a bit here
	# upstream has been notified
	emake -j1 DESTDIR=${D} install
}
