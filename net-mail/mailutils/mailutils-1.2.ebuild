# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-1.2.ebuild,v 1.2 2008/05/19 20:20:13 dev-zero Exp $

inherit eutils
DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="nls pam mysql postgres gdbm"
PROVIDE="virtual/mailx"
DEPEND="!virtual/mailx
	!mail-client/nmh
	!mail-client/elm
	dev-scheme/guile
	gdbm? ( sys-libs/gdbm )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )
	nls? ( sys-devel/gettext )
	virtual/mta"

pkg_setup() {
	# Default to MySQL if USE="mysql postgres', bug #58162.
	if use mysql && use postgres; then
		echo
		ewarn "You have both 'mysql' and 'postgres' in your USE flags."
		ewarn "Portage will build this package with MySQL support."
		echo
		ewarn "If this is not what you want, then change your"
		ewarn "USE flags and emerge this package again."
	fi
}

src_compile() {

	local myconf="--localstatedir=/var --sharedstatedir=/var --enable-mh-utils"

	# bug in autoconf logic treats both --with and --without as set,
	# so we cannot do use_with
	# use mysql && myconf="${myconf} --with-mysql"
	# use postgres && myconf="${myconf} --with-postgres"
	if use mysql && use postgres; then
		einfo "build with MySQL support."
		myconf="${myconf} --with-mysql"
	elif use mysql; then
		einfo "build with MySQL support."
		myconf="${myconf} --with-mysql"
	elif use postgres; then
		einfo "build with PotsgreSQL support."
		myconf="${myconf} --with-postgres"
	fi

	# do not disable-sendmail for postfix user, bug #44249.
	has_postfix=$(best_version mail-mta/postfix)
	has_postfix=${has_postfix%-[0-9]*}
	has_postfix=${has_postfix##*\/}

	if [ "$has_postfix" == "postfix" ]; then
		einfo "postfix detected - enabling sendmail"
	else
		myconf="${myconf} --disable-sendmail"
		einfo "disabling sendmail"
	fi

	myconf="${myconf} $(use_enable nls) $(use_enable pam) $(use_enable gdbm)"
	econf ${myconf} || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	# mail.rc stolen from mailx, resolve bug #37302.
	insinto /etc
	doins "${FILESDIR}/mail.rc"
}
