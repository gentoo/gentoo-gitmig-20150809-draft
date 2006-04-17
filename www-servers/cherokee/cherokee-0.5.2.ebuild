# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.5.2.ebuild,v 1.1 2006/04/17 10:53:27 bass Exp $

inherit eutils pam

NAME=cherokee
S="${WORKDIR}/${NAME}-${PV}"

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.0x50.org/download/${PV%.*}/${PV}/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://www.0x50.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="ipv6 ssl gnutls static doc pam fastcgi scgi"

RDEPEND=">=sys-libs/zlib-1.1.4-r1
	gnutls? ( net-libs/gnutls )
	ssl? ( dev-libs/openssl )
	pam? ( virtual/pam )"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.5"

src_unpack() {
	unpack ${A}
	cd ${S}

	# remove "doc" from SUBDIRS so that html docs don't get installed
	# to the wrong place (/usr/share/doc/cherokee) and we can install
	# them conditionally via dohtml in src_install.
	sed -i -e 's|\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"

	# use cherokee user/group
	sed -i -e 's|^#\(User \).*$|\1cherokee|' \
		   -e 's|^#\(Group \).*$|\1cherokee|' cherokee.conf.sample.pre || \
		   die "sed cherokee.conf failed"
}

src_compile() {
	local myconf

	if use ssl && use gnutls ; then
		myconf="${myconf} --enable-tls=gnutls"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf}  --enable-tls=openssl"
	else
		myconf="${myconf} --disable-tls"
	fi

	if use static ; then
		myconf="${myconf} --enable-static --enable-static-module=all"
	else
		myconf="${myconf} --disable-static"
	fi

	if use fastcgi ; then
		myconf="${myconf} --enable-fcgi"
	fi

	if use scgi ; then
		myconf="${myconf} --enable-scgi"
	fi

	econf \
		${myconf} \
		$(use_enable pam) \
		$(use_enable ipv6) \
		--enable-os-string="Gentoo Linux" \
		--with-wwwroot=/var/www/localhost/htdocs \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	use doc && dohtml -r doc/*

	newpamd pam.d_cherokee ${PN} || die "newpamd failed"
	newinitd ${FILESDIR}/${PN}-0.4.17-init.d ${PN} || die "newinitd failed"

	# be nice and don't overwrite a user's pre-existing index.html
	# (unless they're the same).
	if [[ -f ${ROOT}/var/www/localhost/htdocs/index.html ]] ; then
		diff ${ROOT}/var/www/localhost/htdocs/index.html \
		${D}/var/www/localhost/htdocs/index.html &>/dev/null || \
			mv ${D}/var/www/localhost/htdocs/{,cherokee-}index.html
	fi
}

pkg_postinst() {
	enewgroup cherokee
	enewuser cherokee -1 -1 /var/www/localhost cherokee
	echo
	einfo "Since version 0.4.30 /etc/cherokee/mime.conf is deprecated so"
	einfo "you need to update your cherokee.conf with: "
	einfo "		""MimeFile /etc/cherokee/mime.types"
	einfo "		""MimeFile /etc/cherokee/mime.compression.types"
	echo
}
