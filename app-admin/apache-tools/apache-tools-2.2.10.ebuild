# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apache-tools/apache-tools-2.2.10.ebuild,v 1.6 2009/01/09 17:26:40 ranger Exp $

inherit flag-o-matic eutils

DESCRIPTION="Useful Apache tools - htdigest, htpasswd, ab, htdbm"
HOMEPAGE="http://httpd.apache.org/"
SRC_URI="mirror://apache/httpd/httpd-${PV}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="ssl"
RESTRICT="test"

RDEPEND="=dev-libs/apr-1*
	=dev-libs/apr-util-1*
	dev-libs/libpcre
	ssl? ( dev-libs/openssl )
	!<www-servers/apache-2.2.4"

DEPEND="${RDEPEND}"

S="${WORKDIR}/httpd-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply these patches:
	# (1)	apache-tools-Makefile.patch:
	#		- fix up the `make install' for support/
	#		- remove envvars from `make install'
	epatch "${FILESDIR}"/${PN}-Makefile.patch
}

src_compile() {
	local myconf=""
	cd "${S}"

	# Instead of filtering --as-needed (bug #128505), append --no-as-needed
	# Thanks to Harald van Dijk
	append-ldflags -Wl,--no-as-needed

	if use ssl ; then
		myconf="${myconf} --with-ssl=/usr --enable-ssl"
	fi

	# econf overwrites the stuff from config.layout, so we have to put them into
	# our myconf line too
	econf \
		--sbindir=/usr/sbin \
		--with-z=/usr \
		--with-apr=/usr \
		--with-apr-util=/usr \
		--with-pcre=/usr \
		${myconf} || die "econf failed!"

	cd support
	emake || die "emake support/ failed!"
}

src_install () {
	cd "${S}"/support

	make DESTDIR="${D}" install || die "make install failed!"

	# install manpages
	doman "${S}"/docs/man/{dbmmanage,htdigest,htpasswd,htdbm}.1 \
		"${S}"/docs/man/{ab,htcacheclean,logresolve,rotatelogs}.8

	# Providing compatiblity symlinks for #177697 (which we'll stop to install
	# at some point).

	for i in $(ls "${D}"/usr/sbin 2>/dev/null); do
		dosym /usr/sbin/${i} /usr/sbin/${i}2
	done

	# Provide a symlink for ab-ssl
	if use ssl ; then
		dosym /usr/sbin/ab /usr/sbin/ab-ssl
		dosym /usr/sbin/ab /usr/sbin/ab2-ssl
	fi

	# make htpasswd accessible for non-root users
	dosym /usr/sbin/htpasswd /usr/bin/htpasswd

	dodoc "${S}"/CHANGES
}
