# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/privoxy/privoxy-2.9.14_beta.ebuild,v 1.2 2002/08/16 03:01:02 murphy Exp $

SLOT="2"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
HOMEPAGE="http://www.privoxy.org"
DESCRIPTION="A web proxy with advanced filtering capabilities for protecting privacy against internet junk."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ijbswa/privoxy-2.9.14-beta-src.tar.gz"

pkg_setup() {

	if ! grep -q ^privoxy: /etc/group ; then
		groupadd privoxy || die "problem adding group privoxy"
	fi

	if ! grep -q ^privoxy: /etc/passwd ; then
		useradd  -g privoxy -s /bin/false -d /etc/privoxy -c "privoxy" privoxy\
			|| die "problem adding user apache"
	fi
}

src_unpack() {
	unpack privoxy-2.9.14-beta-src.tar.gz
	patch -p0 < ${FILESDIR}/privoxy-gentoo.diff
	cd ${WORKDIR}/privoxy-2.9.14-beta
	autoheader || die "autoheader failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	cd ${WORKDIR}/privoxy-2.9.14-beta

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/privoxy \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "make failed."

}

src_install () {
	cd ${WORKDIR}/privoxy-2.9.14-beta

	diropts -m 0750 -g privoxy -o privoxy
	dodir /var/log/privoxy
	dodir /etc/privoxy /etc/privoxy/templates

	insopts -m 0640 -g privoxy -o privoxy
	insinto /etc/privoxy
	doins default.filter trust default.action config

	insinto /etc/privoxy/templates
	doins templates/*

	doman privoxy.1

	dodoc LICENSE README AUTHORS doc/text/faq.txt ChangeLog

	insopts
	for i in developer-manual faq man-page user-manual
	do
		insinto /usr/share/doc/${PF}/$i
		doins doc/webserver/$i/*
	done

	insopts -m 0754 -g privoxy -o privoxy
	insinto /etc/init.d
	newins ${FILESDIR}/privoxy.rc6 privoxy

	insopts -m 0750 -g privoxy -o privoxy
	insinto /usr/sbin
	doins privoxy
}
