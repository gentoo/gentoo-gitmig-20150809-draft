# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-0.5.ebuild,v 1.4 2004/07/27 00:39:13 langthang Exp $

inherit eutils
DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mailwrapper nls pam mysql postgres gdbm"
PROVIDE="virtual/mailx"
DEPEND="!virtual/mailx
	!mail-client/nmh
	dev-util/guile
	gdbm? ( sys-libs/gdbm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	nls? ( sys-devel/gettext )
	virtual/mta"

pkg_setup() {
	# Default to MySQL if USE="mysql postgres', bug #58162.
	if use mysql && use postgres; then
		echo
		ewarn "You have both 'mysql' and 'postgres' in your USE flags."
		ewarn "Portage will build this package with MySQL support."
		echo
		ewarn "If this is not what you want; please hit Control-C now;"
		ewarn "change you USE flags then emerge this package again."
		echo
		ewarn "Waiting 30 seconds before continuing..."
		ewarn "(Control-C to abort)..."
		sleep 30
	fi
}
src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-mh-Makefile.in.patch
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

	# do not disable-sendmail for postfix user w/o mailwrapper, bug #44249.
	mymta=$(best_version virtual/mta)
	mymta=${mymta%-[0-9]*}
	mymta=${mymta##*\/}
	if ! use mailwrapper && [ "$mymta" == "postfix" ]; then
		myconf="${myconf} --enable-sendmail"
		einfo "My MTA is: $mymta"
		einfo "enable-sendmail"
	else
		myconf="${myconf} --disable-sendmail"
		einfo "My MTA is: $mymta"
		einfo "disable-sendmail"
	fi

	myconf="${myconf} $(use_enable nls) $(use_enable pam) $(use_enable gdbm)"
	econf ${myconf} || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die
	# mail.rc stolen from mailx, resolve bug #37302.
	insinto /etc
	doins "${FILESDIR}/mail.rc"
}
