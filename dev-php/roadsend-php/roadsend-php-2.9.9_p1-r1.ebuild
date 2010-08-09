# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/roadsend-php/roadsend-php-2.9.9_p1-r1.ebuild,v 1.1 2010/08/09 22:37:47 mabi Exp $

EAPI=2
inherit autotools eutils multilib

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="PHP compiler"
HOMEPAGE="http://code.roadsend.com/pcc"
SRC_URI="http://code.roadsend.com/snaps/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fastcgi mysql odbc pcre sqlite xml"

DEPEND="dev-scheme/bigloo
	net-misc/curl
	mysql? ( dev-db/mysql )
	sqlite? ( dev-db/sqlite:3 )
	pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	odbc? ( dev-db/unixODBC )
	fastcgi? ( dev-libs/fcgi )"
RDEPEND="${DEPEND}"

# Upstream comment: "Sorry, most of the pain here seems to come from bigloo. In our new
# rewrite (which is far from ready, however), bigloo is out of the picture."
# So - in short, not worth the PITA and waste of time until 3.0.0 is out.
QA_PRESTRIPPED="usr/bin/pcc
		usr/bin/pdb
		usr/bin/pcc.fcgi
		usr/bin/pcctags"
QA_DT_HASH="usr/$(get_libdir)/libphp-pdo_u-3.2b.so"
QA_SONAME="usr/$(get_libdir)/libfastcgi_u-3.2b.so
	    usr/$(get_libdir)/libmhttpd_u-3.2b.so
	    usr/$(get_libdir)/libpcc-rl_u-3.2b.so
	    usr/$(get_libdir)/libphp.*
	    usr/$(get_libdir)/libprofiler_u-3.2b.so
	    usr/$(get_libdir)/libwebconnect_u-3.2b.so
	    usr/$(get_libdir)/libwebserver.so"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# respect CFLAGS/LDFLAGS
	# Upstream bugs: http://code.roadsend.com/pcc/ticket/3495
	# http://code.roadsend.com/pcc/ticket/3531
	# note the ugly ^M gremlins and make the patch not fail
	# with DOS line endings depending on sys-devel/patch version installed
	edos2unix bigloo-rules.mk || die "failed to sanitize bigloo-rules.mk"
	for i in runtime/Makefile compiler/Makefile tools/c-interface/Makefile \
		    tools/profiler/Makefile tools/readline/Makefile webconnect/fastcgi/Makefile \
		    webconnect/micro/Makefile ; do
		mv -f ${i} ${i}.in || die "mv ${i} failed"
	done
	epatch "${FILESDIR}/${P}-flags.patch"
	# Bigloo needs -copt/-ldopt prefixed before *each* of CFLAGS/LDFLAGS
	# Without this you get flooded with tons of "Don't know what to do with arguments" messages
	local bcflags bldflags pcccflags pccldflags pccpropercflags pccproperldflags
	if [[ -n ${CFLAGS} ]] ; then
		for x in ${CFLAGS}; do
			bcflags="${bcflags} -copt ${x}"
		done
		sed -i -e "s:@@CFLAGS@@:${bcflags}:g" bigloo-rules.mk || die "sed failed"
	else
		sed -i -e "s:@@CFLAGS@@::g" bigloo-rules.mk || die "sed failed"
	fi
	if [[ -n ${LDFLAGS} ]] ; then
		for x in ${LDFLAGS} ; do
			bldflags="${bldflags} -ldopt ${x}"
		done
		sed -i -e "s:@@LDFLAGS@@:${bldflags}:g" bigloo-rules.mk || die "sed failed"
	else
		sed -i -e "s:@@LDFLAGS@@::g" bigloo-rules.mk || die "sed failed"
	fi

	# See http://code.roadsend.com/pcc/ticket/3523 for reasons for this madness
	# Also, pcc itself only accepts --copt/--ldopt instead of -copt/-ldopt used for bigloo
	if [[ -n ${CFLAGS} ]] ; then
		for x in ${CFLAGS}; do
			pcccflags="${pcccflags} --bopt -copt --bopt ${x}"
			pccpropercflags="${pccpropercflags} --copt ${x}"
		done
		sed -i -e "s:@@CFLAGS@@:${pcccflags}:" runtime/php-ext/php-extensions.mk || die "sed failed"
		sed -i -e "s:@@PCCCFLAGS@@:${pccpropercflags}:" runtime/php-ext/php-extensions.mk || die "sed failed"
	else
		sed -i -e "s:@@PCCCFLAGS@@::" runtime/php-ext/php-extensions.mk || die "sed failed"
		sed -i -e "s:@@PCCCFLAGS@@::" runtime/php-ext/php-extensions.mk || die "sed failed"
	fi
	if [[ -n ${LDFLAGS} ]] ; then
		for x in ${LDFLAGS}; do
			pccldflags="${pccldflags} --bopt -ldopt --bopt ${x}"
			pccproperldflags="${pccproperldflags} --ldopt ${x}"
		done
		sed -i -e "s:@@LDFLAGS@@:${pccldflags}:" runtime/php-ext/php-extensions.mk || die "sed failed"
		sed -i -e "s:@@PCCLDFLAGS@@:${pccproperldflags}:" runtime/php-ext/php-extensions.mk || die "sed failed"
	else
		sed -i -e "s:@@LDFLAGS@@::" runtime/php-ext/php-extensions.mk || die "sed failed"
		sed -i -e "s:@@PCCLDFLAGS@@::" runtime/php-ext/php-extensions.mk || die "sed failed"
	fi

	eautoreconf
}

src_configure() {
	econf $(use_with pcre) \
		$(use_with fastcgi fcgi) \
		$(use_with xml) \
		$(use_with mysql) \
		$(use_with sqlite sqlite3) \
		$(use_with odbc)
}

src_compile() {
	if use debug; then
		emake -j1 debug || die "make debug failed"
	else
		emake -j1 || die "make failed"
	fi
}

src_test() {
	LD_LIBRARY_PATH="${S}/libs/" emake -j1 test || die "standalone tests failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
}
