# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/tpop3d/tpop3d-1.4.2.ebuild,v 1.5 2003/06/12 21:33:32 msterret Exp $

inherit eutils

IUSE="ssl ldap mysql perl pam tcpd maildir"

S=${WORKDIR}/${P}
DESCRIPTION="An extensible POP3 server with vmail-sql/MySQL support."
SRC_URI="http://www.ex-parrot.com/~chris/tpop3d/${P}.tar.gz
	http://www.ex-parrot.com/~chris/tpop3d/${P}-auth-flatfile-broken.patch"
HOMEPAGE="http://www.ex-parrot.com/~chris/tpop3d/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	ssl?	( >=dev-libs/openssl-0.9.6 )
        ldap? 	( >=net-nds/openldap-2.0.7 )
	mysql? 	( >=dev-db/mysql-3.23.28 )
	perl?	( >=dev-lang/perl-5.6.1 )
	pam?	( >=sys-libs/pam-0.75 )
	tcpd?	( >=sys-apps/tcp-wrappers-7.6 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}-auth-flatfile-broken.patch || die
}

src_compile() {
	local myconf
	use mysql		&& myconf="--enable-auth-mysql"
	use ldap		&& myconf="${myconf} --enable-auth-ldap"
	use perl		&& myconf="${myconf} --enable-auth-perl"
	use tcpd		&& myconf="${myconf} --enable-tcp-wrappers"
	use pam			|| myconf="${myconf} --disable-auth-pam"
	use maildir		&& myconf="${myconf} --enable-mbox-maildir"
	# If you want plaintext /etc/passwd authentication
	if [ ! -z $ENABLE_PASSWD ]; then
		myconf="${myconf} --enable-auth-passwd"
	fi
	# If you want to use /etc/shadow instead.  
	# Make sure you also set $ENABLE_PASSWD
	if [ ! -z $ENABLE_SHADOW ]; then
		myconf="${myconf} --enable-shadow-passwords"
	fi
	# authenticate against any passwd-like file
	if [ ! -z $ENABLE_FLATFILE ]; then
		myconf="${myconf} --enable-auth-flatfile"
	fi
	# authenticate via an external program
	if [ ! -z $ENABLE_OTHER ]; then
		myconf="${myconf} --enable-auth-other"
	fi
	# Make it Rated G and safe for the kids 
	if [ ! -z $BE_NICE ]; then
		myconf="${myconf} --disable-snide-comments"
	fi
	# Install net-mail/drac for integration with tpop3d
	if [ ! -a $ENABLE_DRAC ]; then
		myconf="${myconf} --enable-drac"
	fi
	if [ ! -z $DEBUGBUILD ]; then
		myconf="${myconf} --enable-electric-fence --enable-backtrace"
	fi
	econf ${myconf} || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /etc/tpop3d
}
pkg_postinst() {
	einfo "Read the tpop3d.conf manpage"
	einfo "Please create /etc/tpop3d/tpop3d.conf to fit your Configuration"
}				
