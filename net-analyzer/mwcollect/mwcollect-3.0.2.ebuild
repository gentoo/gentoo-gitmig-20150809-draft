# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mwcollect/mwcollect-3.0.2.ebuild,v 1.3 2007/06/26 02:20:54 mr_bones_ Exp $

inherit eutils

DESCRIPTION="mwcollect collects worms and other autonomous spreading malware"
HOMEPAGE="http://www.mwcollect.org/"
SRC_URI="http://download.mwcollect.org/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug"
# has issues right now
#IUSE="debug prelude"

DEPEND="dev-libs/libpcre
	net-misc/curl
	>=sys-libs/libcap-1"
	#   has issues right now
	#	prelude?( >=dev-libs/libprelude-0.9  )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
	-e "s:CXXFLAGS += -I./src/include:CXXFLAGS += ${CXXFLAGS} -fPIC -I./src/include:" \
	Makefile || die "custom CFLAGS patching failed"

	#sed -i \
	#-e "s:\$(MODULE_OBJ) \$(LDFLAGS):\$(MODULE_OBJ) \$(LDFLAGS) -fPIC:" \
	#Makefile.MODULE || die "pic patching failed"

	sed -i \
	-e "s:%loadModule(\":%loadModule(\"\/usr\/lib\/mwcollect\/:g" \
	conf/mwcollect.conf || die "module load directory failed"
}

src_compile() {
	use debug && export DEBUG="y"
	# has issues right now
	#use prelude && export MODULES="log-prelude"

	emake || die "Make failed"
}

src_install() {
	dosbin bin/mwcollectd
	insinto /usr/$(get_libdir)/mwcollect
	doins bin/modules/*

	insinto /etc/mwcollect
	doins conf/* \
		|| die "config file installation failed"

	dodoc README* doc/core-design.txt
	doman doc/mwcollectd.1

	newinitd ${FILESDIR}/initd mwcollectd
	newconfd ${FILESDIR}/confd mwcollectd
}
