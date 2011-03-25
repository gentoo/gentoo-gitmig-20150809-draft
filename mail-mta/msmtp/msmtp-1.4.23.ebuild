# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.4.23.ebuild,v 1.7 2011/03/25 10:06:54 xarthisius Exp $

EAPI=3

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/msmtp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc gnome-keyring gnutls idn +mta nls sasl ssl vim-syntax"

CDEPEND="idn? ( net-dns/libidn )
	nls? ( virtual/libintl )
	gnome-keyring? ( gnome-base/gnome-keyring
		dev-python/gnome-keyring-python )
	gnutls? ( >=net-libs/gnutls-1.2.0 )
	!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
	sasl? ( >=virtual/gsasl-0.2.4 )"

RDEPEND="${CDEPEND}
	mta? ( !virtual/mta )
	!net-mail/mailwrapper"

DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

PROVIDE="mta? ( virtual/mta )"

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

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	if use mta ; then
		dodir /usr/sbin
		dosym /usr/bin/msmtp /usr/sbin/sendmail || die "dosym failed"
	fi

	dodoc AUTHORS ChangeLog NEWS README THANKS \
		doc/{Mutt+msmtp.txt,msmtprc*} || die "dodoc failed"

	if use doc ; then
		dohtml doc/msmtp.html || die "dohtml failed"
		dodoc doc/msmtp.pdf
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/syntax
		doins scripts/vim/msmtp.vim || die "doins syntax failed"
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
		doexe scripts/$subdir/$i || die "doexe $subdir/$i failed"
	done
	for i in $docs ; do
		newdoc scripts/$subdir/$i $subdir.$i \
			|| die "dodoc $subdir/$i failed"
	done
}
