# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-0.3.1-r1.ebuild,v 1.3 2004/07/15 01:50:31 agriffis Exp $

inherit eutils
DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls pam mysql postgres gdbm"
DEPEND="!mail-client/mailx
	!mail-client/nmh
	dev-util/guile
	gdbm? ( sys-libs/gdbm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	nls? ( sys-devel/gettext )"

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

	local myconf=""

	# bug in autoconf logic treats both --with and --without as set,
	# so we cannot do use_with
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-postgres"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--sharedstatedir=/var \
		--mandir=/usr/share/man \
		--disable-sendmail \
		--enable-mh-utils \
		`use_enable nls` \
		`use_enable pam` \
		`use_with gdbm` \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
