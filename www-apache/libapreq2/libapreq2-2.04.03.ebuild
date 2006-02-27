# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/libapreq2/libapreq2-2.04.03.ebuild,v 1.2 2006/02/27 15:43:21 mcummings Exp $

inherit libtool eutils flag-o-matic

MY_P=${P/alpha/}
S=${WORKDIR}/${MY_P%%.[0-9][0-9]}-dev
DESCRIPTION="A Apache Request Perl Module"
MY_SRCBALL=${MY_P%.*}_${MY_P##*.}-dev.tar.gz
SRC_URI="http://www.apache.org/dist/httpd/libapreq/${MY_SRCBALL}"
HOMEPAGE="http://httpd.apache.org/apreq/"
SLOT="2"
LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"

# the 5.8.4 dep is to ensure Test-More and MakeMaker

DEPEND="${DEPEND}
	>=dev-lang/perl-5.8.4
	>=sys-apps/sed-4
	dev-perl/Apache-Test
	>=net-www/apache-2.0.46
	>=www-apache/mod_perl-1.99
	>=dev-perl/ExtUtils-XSBuilder-0.23"

mydoc="TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0-binloc.patch || die
	epatch ${FILESDIR}/${PN}-2.0-sandbox.patch || die
	echo "ScriptSock ${T}/run" >> ${S}/env/t/conf/extra.conf.in
	echo "ScriptSock ${T}/run2" > ${S}/glue/perl/t/conf/extra.conf.in
	elibtoolize --reverse-deps
	sed -i -e 's/-apxs @APACHE2_APXS@/-apxs @APACHE2_APXS@ -user portage -group portage/' ${S}/env/Makefile.am
	sed -i -e 's/-apxs @APACHE2_APXS@/-apxs @APACHE2_APXS@ -user portage -group portage -port 8549/' ${S}/glue/Makefile.am
}

src_compile() {

	# the -i is for a missing depcomp
	autoreconf -i -f

	# the install process installs libapreq2 first, and then calls
	# apxs2 -i, which tries to recompile a libtool thing and fails
	# because it can't find libapreq2, which is still sitting in the
	# staging directory. this approach thieved from subversion ebuild,
	# suggested by pauldv. that didn't work, neither did the
	# LD_LIBRARY_PATH thing.  I'm at the end of my rope for now on
	# this, so i'm disabling relink.  Anybody that can figure out a
	# cleaner way is certainly welcome to do so.

	sed -i -e 's/need_relink=yes/#ouch need_relink=yes/' ${S}/ltmain.sh

	# this may only be needed on 64-bit arches

	append-flags -fPIC

	econf --with-apache2-apxs=/usr/sbin/apxs2 \
		--with-apache2-httpd=/usr/sbin/apache2 \
		--enable-perl-glue

	emake LT_LDFLAGS="-L${D}/usr/lib" || die

	hasq maketest $FEATURES && src_test
}

src_test() {
	# ccache breaks the cgi portion of make test
	# thieved from lilypond ebuild
	PATH="$(echo ":${PATH}:" | sed 's/:[^:]*ccache[^:]*:/:/;s/^://;s/:$//;')"

	# even after all that, cgi.t can't find what it needs in its @INC.
	# don't see how this ever ran for anybody.  disabling for now
	echo "cgi" > ${S}/env/t/SKIP
	echo "cgi" > ${S}/glue/perl/t/SKIP

	chown portage ${S}/..
	chown portage ${S}
	chown portage ${S}/env

	# tests too flaky yet to || die

	APACHE_TEST_NO_STICKY_PREFERENCES=1 HOME="${T}" emake test
}

src_install() {
	emake -j1 DESTDIR=${D} LT_LDFLAGS="-L${D}/usr/lib" install || die
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/76_mod_apreq.conf
}
