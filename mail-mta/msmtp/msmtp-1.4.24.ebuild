# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.4.24.ebuild,v 1.2 2011/05/15 16:57:10 eras Exp $

EAPI=4

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/msmtp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc gnome-keyring gnutls idn +mta nls sasl ssl vim-syntax"

CDEPEND="idn? ( net-dns/libidn )
	nls? ( virtual/libintl )
	gnome-keyring? ( gnome-base/gnome-keyring
		dev-python/gnome-keyring-python )
	gnutls? ( >=net-libs/gnutls-1.2.0 )
	!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
	sasl? ( >=virtual/gsasl-0.2.4 )"

RDEPEND="${CDEPEND}
	mta? (	!mail-mta/courier
			!mail-mta/esmtp
			!mail-mta/exim
			!mail-mta/mini-qmail
			!mail-mta/nbsmtp
			!mail-mta/netqmail
			!mail-mta/nullmailer
			!mail-mta/postfix
			!mail-mta/qmail-ldap
			!mail-mta/sendmail
			!<mail-mta/ssmtp-2.64-r2
			!>=mail-mta/ssmtp-2.64-r2[mta] )"

DEPEND="${CDEPEND}
	doc? ( virtual/texi2dvi )
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	# Use default Gentoo location for mail aliases
	sed -i -e 's:/etc/aliases:/etc/mail/aliases:' scripts/find_alias/find_alias_for_msmtp.sh
}

src_configure() {
	local myconf

	if use gnutls ; then
		myconf="--with-ssl=gnutls"
	elif use ssl ; then
		myconf="--with-ssl=openssl"
	else
		myconf="--with-ssl=no"
	fi

	econf \
		$(use_with idn libidn) \
		$(use_with sasl libgsasl) \
		$(use_with gnome-keyring ) \
		$(use_enable nls) \
		${myconf}
}

src_compile() {
	default_src_compile
	if use doc ; then
		cd doc || die "cd failed"
		emake html pdf
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	if use mta ; then
		dodir /usr/sbin
		dosym /usr/bin/msmtp /usr/sbin/sendmail
	fi

	dodoc AUTHORS ChangeLog NEWS README THANKS doc/{Mutt+msmtp.txt,msmtprc*}

	if use doc ; then
		dohtml doc/msmtp.html
		dodoc doc/msmtp.pdf
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/syntax
		doins scripts/vim/msmtp.vim
	fi

	if use gnome-keyring ; then
		src_install_contrib msmtp-gnome-tool "msmtp-gnome-tool.py" "README"
	fi

	src_install_contrib find_alias "find_alias_for_msmtp.sh"
	src_install_contrib msmtpqueue "*.sh" "README ChangeLog"
	src_install_contrib msmtpq "msmtpq msmtpQ" "README"
	src_install_contrib set_sendmail "set_sendmail.sh" "set_sendmail.conf"
}

src_install_contrib() {
	subdir="$1"
	bins="$2"
	docs="$3"
	local dir=/usr/share/${PN}/$subdir
	insinto ${dir}
	exeinto ${dir}
	for i in $bins ; do
		doexe scripts/$subdir/$i
	done
	for i in $docs ; do
		newdoc scripts/$subdir/$i $subdir.$i
	done
}
