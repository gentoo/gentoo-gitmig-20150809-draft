# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.4.4-r2.ebuild,v 1.3 2006/03/22 17:13:26 mr_bones_ Exp $

inherit eutils

S="${WORKDIR}/jabberd-${PV}"
DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://download.jabberd.org/jabberd14/${P}.tar.gz"
#	ldap? ( http://www.jabberstudio.org/files/xdb_ldap/xdb_ldap-1.0.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
## Arches removed due to dependencie on jabber-base
KEYWORDS="~amd64 ~x86"
IUSE="ssl ipv6 msn oscar yahoo icq mysql postgres" #ldap


DEPEND="!net-im/jabber-server
	net-im/jabber-base
	>=dev-libs/pth-1.4.0
	dev-libs/expat
	ssl? ( >=dev-libs/openssl-0.9.6i )"
#	ldap? ( =net-nds/openldap-2* )"

PDEPEND="msn? ( net-im/pymsn-t )
		 oscar? ( net-im/aim-transport )
		 yahoo? ( net-im/yahoo-transport )
		 icq? ( net-im/jit )"

pkg_setup() {

	ewarn "This is a test release and LDAP has been disabled for everyone"

	if use ipv6 ; then
		ewarn "You are about to build with ipv6 support, if your system is not using ipv6"
		ewarn "do control-c now and emerge with \"USE=-ipv6\" or add it to /etc/portage/package.use "
		#epause 5
	fi
}

src_unpack() {
	unpack jabberd-${PV}.tar.gz
	cd ${S}
	#use ldap	&& unpack xdb_ldap-1.0.tar.gz
	#mv jabberd/jabberd.c jabberd/jabberd.c.orig
	#sed 's:pstrdup(jabberd__runtime,HOME):"/var/spool/jabber":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	#rm -f jabberd/jabberd.c.orig

}

src_compile() {
	# These can cause problems with certain configure scripts used...
	unset LC_ALL LC_CTYPE

	local myconf
	myconf=" --sysconfdir=/etc/jabber "
	cd ${S}
	use ssl && myconf="${myconf} --enable-ssl"
	use ipv6 && myconf="${myconf} --enable-ipv6"
	use mysql && myconf="$myconf --with-mysql"
	use postgres && myconf="$myconf --with-postgresql"
	echo ${myconf}
	econf ${myconf} || die
	make || die

#	if use ldap; then
#		cd ${S}/xdb_ldap/src
#		make all || die
#	fi
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/conf.d ; newins ${FILESDIR}/jabber-conf.d jabber
	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r8 jabber
	dosed 's/\/var\/lib\/spool\/jabberd/\/var\/spool\/jabber/g' /etc/jabber/jabber.xml
	dosed 's/\/var\/lib\/log\/jabberd/\/var\/log\/jabber/g' /etc/jabber/jabber.xml
	dosed 's/\/var\/lib\/run\/jabberd/\/var\/run\/jabber/g' /etc/jabber/jabber.xml
	dosed 's/\/var\/lib\/spool\/jabberd/\/var\/spool\/jabber/g' /etc/jabber/jabber.xml.dist
	dosed 's/\/var\/lib\/log\/jabberd/\/var\/log\/jabber/g' /etc/jabber/jabber.xml.dist
	dosed 's/\/var\/lib\/run\/jabberd/\/var\/run\/jabber/g' /etc/jabber/jabber.xml.dist
	dosed 's/jabber.pid/jabberd14.pid/g' /etc/jabber/jabber.xml
	dosed 's/jabber.pid/jabberd14.pid/g' /etc/jabber/jabber.xml.dist

	#Change the config file to the older name

	mv ${D}/etc/jabber/jabber.xml ${D}/etc/jabber/multiple.xml
	mv ${D}/etc/jabber/jabber.xml.dist ${D}/etc/jabber/multiple.xml.dist

	}

pkg_postinst() {

	einfo
	einfo "Change 'localhost' to your server's domainname in the"
	einfo "/etc/jabber/*.xml configs first"
	einfo "Server admins should be added to the "jabber" group"
	if use ssl; then
		einfo
		einfo "To enable SSL connections, execute /etc/jabber/self-cert.sh"
	fi

	#if use ldap; then
	#	einfo
	#	einfo "In order to use the ldap backend, you need to copy"
	#	einfo "the file /etc/jabber/jabber.schema into the /etc/openldap/schemas"
	#	einfo "directory on your ldap server. You will also need to"
	#	einfo "include the schema in your slapd.conf file and retsart openldap."
	#	einfo "An example slapd.conf file is included in /etc/jabber."
	#	einfo "The xdb_ldap backend expects your ldap server to handle"
	#	einfo "StartTLS or run in ldaps mode."
	#fi
	einfo
	einfo "The various IM transports for jabber are now separate packages,"
	einfo "which you will need to install separately if you want them:"
	einfo "net-im/jit - ICQ transport (You can use aim-transport for icq but JIT is better)"
	einfo "net-im/pymsn-t - MSN transport (USE=msn)"
	einfo "net-im/jud - Jabber User Directory"
	einfo "net-im/yahoo-transport - Yahoo IM system (USE=yahoo)"
	einfo "net-im/aim-transport - AOL transport (USE=oscar)"
	einfo "net-im/mu-conference - Jabber multi user conference"
	einfo
	einfo "Please read /usr/share/doc/${PF}/README.Gentoo.gz"
	einfo
	ewarn "If upgrading from older version please stop jabberd BEFORE updating the init.d"
	ewarn "script, or you will end with a \"dead\" server."
}
