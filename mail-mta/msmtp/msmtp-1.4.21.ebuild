# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/msmtp/msmtp-1.4.21.ebuild,v 1.1 2010/07/12 23:31:59 jer Exp $

EAPI=2
inherit eutils

DESCRIPTION="An SMTP client and SMTP plugin for mail user agents such as Mutt"
HOMEPAGE="http://msmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/msmtp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc gnome-keyring gnutls idn mailwrapper nls sasl ssl +mta"

DEPEND="idn? ( net-dns/libidn )
	nls? ( virtual/libintl )
	gnome-keyring? ( gnome-base/gnome-keyring )
	gnutls? ( >=net-libs/gnutls-1.2.0 )
	!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
	sasl? ( >=virtual/gsasl-0.2.4 )"

RDEPEND="${DEPEND}
	mta? (
		!mailwrapper? ( !virtual/mta )
		mailwrapper? ( >=net-mail/mailwrapper-0.2 )
	)"

DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

PROVIDE="mta? ( virtual/mta )"

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

	if use mta; then
		if use mailwrapper ; then
			insinto /etc/mail
			doins "${FILESDIR}"/mailer.conf
		else
			dodir /usr/sbin
			dosym /usr/bin/msmtp /usr/sbin/sendmail || die "dosym failed"
		fi
	fi

	dodoc AUTHORS ChangeLog NEWS README THANKS \
		doc/{Mutt+msmtp.txt,msmtprc*} || die "dodoc failed"

	if use doc ; then
		dohtml doc/msmtp.html || die "dohtml failed"
		dodoc doc/msmtp.pdf
	fi

	#d=msmtpqueue
	#local msmtpqueue=/usr/share/${PN}/$d
	#insinto ${msmtpqueue}
	#exeinto ${msmtpqueue}
	#doexe scripts/msmtpqueue/*.sh || die "doexe failed"
	#for i in ChangeLog README ; do
	#	newdoc scripts/msmtpqueue/$i msmtpqueue.$i \
	#		|| die "dodoc scripts/msmtpqueue/$i failed"
	#done

	#d=msmtpq
	#local msmtpq=/usr/share/${PN}/$d
	#insinto ${msmtpqueue}
	#exeinto ${msmtpqueue}
	#i=README
	#newdoc scripts/$d/$i $d.$i \
	#	|| die "dodoc scripts/$d/$i failed"

	src_install_contrib msmtpqueue "*.sh" "README ChangeLog"
	src_install_contrib msmtpq "msmtpq msmtpQ" "README"

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
