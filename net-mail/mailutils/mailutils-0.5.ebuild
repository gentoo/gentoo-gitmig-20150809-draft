# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-0.5.ebuild,v 1.3 2004/07/14 20:55:53 langthang Exp $

inherit eutils
DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mailwrapper nls pam mysql postgres gdbm"
DEPEND="!mail-client/mailx
	!mail-client/nmh
	dev-util/guile
	gdbm? ( sys-libs/gdbm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	nls? ( sys-devel/gettext )
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-mh-Makefile.in.patch
}

src_compile() {
	# Shamelessly stolen from nagios-core
	if use mysql && use postgres; then
		eerror "Unfortunatly you can't have both MySQL and PostgreSQL enabled at the same time."
		eerror "You have to remove either 'mysql' or 'postgres' from your USE flags before emerging this."

		has_version ">=sys-apps/portage-2.0.50" && (
			einfo "You can alternatively add"
			einfo "net-mail/mailutils [use flags]"
			einfo "to the file:"
			einfo "/etc/portage/package.use"
			einfo "to permamently set this package's USE flags"
		)

		exit 1
	fi

	local myconf="--localstatedir=/var --sharedstatedir=/var --enable-mh-utils"

	# bug in autoconf logic treats both --with and --without as set,
	# so we cannot do use_with
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-postgres"

	# do not disable-sendmail for postfix user w/o mailwrapper, bug #44249.
	mymta=$(portageq best_version / virtual/mta)
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
