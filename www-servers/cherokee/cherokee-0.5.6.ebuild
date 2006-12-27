# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.5.6.ebuild,v 1.3 2006/12/27 05:02:31 flameeyes Exp $

inherit eutils pam versionator libtool

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.cherokee-project.com/download/$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.cherokee-project.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6 ssl gnutls static pam coverpage threads"

RDEPEND=">=sys-libs/zlib-1.1.4-r1
	gnutls? ( net-libs/gnutls )
	ssl? ( dev-libs/openssl )
	pam? ( virtual/pam )"

src_unpack() {
	unpack ${A}

	elibtoolize

	# use cherokee user/group
	sed -i -e 's|^#\(User \).*$|\1cherokee|' \
		   -e 's|^#\(Group \).*$|\1cherokee|' "${S}/cherokee.conf.sample.pre" || \
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

	local os="Unknown"
	case "${CHOST}" in
		*-freebsd*)
			os="FreeBSD" ;;
		*-netbsd*)
			os="NetBSD" ;;
		*-openbsd*)
			os="OpenBSD" ;;
		*)
			os="Linux" ;;
	esac

	econf \
		${myconf} \
		$(use_enable pam) \
		$(use_enable ipv6) \
		$(use_enable threads pthread) \
		--disable-dependency-tracking \
		--enable-os-string="Gentoo ${os}" \
		--with-wwwroot=/var/www/localhost/htdocs \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}/html" install || die "make install failed"
	dodoc AUTHORS ChangeLog TODO

	newpamd pam.d_cherokee ${PN} || die "newpamd failed"
	newinitd "${FILESDIR}/${PN}-initd-0.5.6" ${PN} || die "newinitd failed"

	keepdir /etc/cherokee/mods-enabled /etc/cherokee/sites-enabled /var/www/localhost/htdocs

	use coverpage || rm -rf "${D}"/var/www/localhost/htdocs/{index.html,images}
}

pkg_postinst() {
	enewgroup cherokee
	enewuser cherokee -1 -1 /var/www/localhost cherokee
}
