# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bacula/bacula-1.32f-r5.ebuild,v 1.4 2004/04/09 16:39:27 zul Exp $

MY_P="bacula-1.32f-5"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="featureful client/server network backup suite"
HOMEPAGE="http://www.bacula.org/"
SRC_URI="mirror://sourceforge/bacula/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="readline tcpd ssl gnome mysql sqlite X static"

#theres a local sqlite use flag. use it -OR- mysql, not both.
#mysql is the reccomended choice ...
DEPEND="sys-libs/libtermcap-compat
	>=sys-libs/zlib-1.1.4
	readline? >=sys-libs/readline-4.1
	tcpd? >=sys-apps/tcp-wrappers-7.6
	ssl? >=dev-libs/openssl-0.9.6
	gnome? gnome-base/gnome-libs
	sqlite? >=dev-db/sqlite-2.7
	mysql? >=dev-db/mysql-3.23
	X? virtual/x11
	virtual/mta
	dev-libs/gmp"
RDEPEND="${DEPEND}
	sys-apps/mtx
	app-arch/mt-st"

src_compile() {
	local myconf=""

	#define this to skip building the other daemons ...
	[ -n "$BUILD_CLIENT_ONLY" ] \
		&& myconf="${myconf} --enable-client-only"

	#might be handy to have static bins in certain situations ...
	#use static \
	#	&& myconf="${myconf} --enable-static-tools \
	#	--enable-static-fd --enable-static-sd \
	#	--enable-static-dir --enable-static-cons"
	myconf="
		`use_enable readline`
		`use_enable gnome`
		`use_enable tcpd`
		`use_enable X x`
		"
	#not ./configure'able
	#`use_enable ssl`

	# mysql is the reccomended choice ...
	if use mysql
	then
		myconf="${myconf} --with-mysql=/usr"
	fi

	if use sqlite
	then
		myconf="${myconf} --with-sqlite=/usr/include"
	fi

	if use sqlite && use mysql
	then
		myconf="${myconf/--with-sqlite/}"
	fi
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-pid-dir=/var/run \
		--sysconfdir=/etc/bacula \
		--infodir=/usr/share/info \
		--with-subsys-dir=/var/lib/bacula \
		--with-working-dir=/var/lib/bacula \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"

	if use static
	then
		cd ${S}/src/filed
		make static-baula-fd
		cd ${S}/src/console
		make static-console
		cd ${S}/src/dird
		make static-bacula-dir
		if use gnome
		then
		  cd ${S}/src/gnome-console
		  make static-gnome-console
		fi
		cd ${S}/src/stored
		make static-bacula-sd
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	if use static
	then
		cd ${S}/src/filed
		cp static-bacula-fd ${D}/usr/sbin/bacula-fd
		cd ${S}/src/console
		cp static-console ${D}/usr/sbin/console
		cd ${S}/src/dird
		cp static-bacula-dir ${D}/usr/sbin/bacula-dir
		if use gnome
		then
			cd ${S}/src/gnome-console
			cp static-gnome-console ${D}/usr/sbin/gnome-console
		fi
		cd ${S}/src/storge
		cp static-bacula-sd ${D}/usr/sbin/bacula-sd
	fi

	rm -rf ${D}/var #empty dir

	for a in ${S}/{ABOUT-NLS,COPYING,Changelog,CheckList,INSTALL \
			README,ReleaseNotes,kernstodo,doc/bacula.pdf}
	do
		dodoc $a
	done

	cp -a ${S}/examples ${D}/usr/share/doc/${PF}
	chown -R root:root ${D}/usr/share/doc/${PF} #hrmph :\
	dohtml -r ${S}/doc/html-manual doc/home-page

	exeinto /etc/init.d
	newexe ${FILESDIR}/bacula-init bacula
}

pkg_postinst() {
	# empty dir ...
	install -m0755 -o root -g root -d ${ROOT}/var/lib/bacula
	einfo
	einfo "If this is a new install and you plan to use mysql for your"
	einfo "catalog database, then you should now create it by doing"
	einfo "these commands:"
	einfo " sh /etc/bacula/grant_mysql_privileges"
	einfo " sh /etc/bacula/create_mysql_database"
	einfo " sh /etc/bacula/make_mysql_tables"
	einfo
	einfo "Then setup your configuration files in /etc/bacula and"
	einfo "start the daemons:"
	einfo " /etc/init.d/bacula start"
	einfo
	einfo "If upgrading from version 1.30 or below, please note that"
	einfo "the database format has changed.  Please read the"
	einfo "release notes for how to upgrade your database!!!"
	einfo
}
