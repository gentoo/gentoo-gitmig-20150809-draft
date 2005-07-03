# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bacula/bacula-1.36.3-r1.ebuild,v 1.1 2005/07/03 03:58:53 fserb Exp $

inherit eutils

DESCRIPTION="featureful client/server network backup suite"
HOMEPAGE="http://www.bacula.org/"
SRC_URI="mirror://sourceforge/bacula/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="readline ncurses tcpd gnome mysql sqlite X static postgres client-only"

DEPEND=">=sys-libs/zlib-1.1.4
	sys-block/mtx
	readline? ( >=sys-libs/readline-4.1 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	gnome? ( gnome-base/libgnome )
	gnome? ( app-admin/gnomesu )
	sqlite? ( =dev-db/sqlite-2* )
	mysql? ( >=dev-db/mysql-3.23 )
	postgres? ( >=dev-db/postgresql-7.4.0 )
	X? ( virtual/x11 )
	ncurses? ( sys-libs/ncurses )
	virtual/mta
	dev-libs/gmp"

RDEPEND="${DEPEND}
	sys-block/mtx
	app-arch/mt-st"

pkg_setup() {
	if ! use mysql && ! use postgres && ! use sqlite && ! use client-only; then
		einfo "Bacula must compile with one database or client only."
		einfo "Please add mysql, postgres, sqlite or client-only to your USE flags."
		einfo "You may add the right USE flags on /etc/portage/package.use if you want to."
		die "Invalid USE flags"
	fi

	if ( use mysql && use sqlite ) ||
		( use mysql && use postgres ) ||
		( use sqlite && use postgres ) ; then
		einfo "For this ebuild to work, only one database may be selected."
		einfo "Please select mysql, postgres OR sqlite only on the USE flags."
		einfo "You may add the right USE flags on /etc/portage/package.use if you want to."
		die "Invalid USE flags"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cdrecord-configure.patch || die "Patch failed"

	# This changes the default conf files to /etc/bacula files
	sed -i -e 's:"./gnome-console.conf":"/etc/bacula/gnome-console.conf":' \
		src/gnome-console/console.c src/gnome2-console/console.c
	sed -i -e 's:"./tray-monitor.conf":"/etc/bacula/tray-monitor.conf":' \
		src/tray-monitor/tray-monitor.c
	sed -i -e 's:"bacula-sd.conf":"/etc/bacula/bacula-sd.conf":' src/stored/bls.c \
		src/stored/bextract.c src/stored/bcopy.c src/stored/bscan.c src/stored/btape.c \
		src/stored/stored.c
	sed -i -e 's:"./bacula-fd.conf":"/etc/bacula/bacula-fd.conf":' src/filed/filed.c
	sed -i -e 's:"./bacula-dir.conf":"/etc/bacula/bacula-dir.conf":' src/dird/dird.c
	sed -i -e 's:"./bconsole.conf":"/etc/bacula/bconsole.conf":' src/console/console.c
}

src_compile() {
	econf --enable-smartalloc \
		--with-dir-user=root \
		--with-dir-group=bacula \
		--with-sd-user=root \
		--with-sd-group=bacula \
		--with-fd-user=root \
		--with-fd-group=bacula \
		--sysconfdir=/etc/bacula \
		--with-subsys-dir=/var/lock/subsys \
		--with-working-dir=/var/bacula \
		--with-scriptdir=/var/lib/bacula \
		`use_enable readline` \
		`use_enable gnome` \
		`use_enable static static-tools` \
		`use_enable static static-fd` \
		`use_enable static static-sd` \
		`use_enable static static-dir` \
		`use_enable static static-cons` \
		`use_enable gnome tray-monitor` \
		`use_enable tcpd tcp-wrappers` \
		`use_enable X x` \
		`use_enable readline` \
		`use_enable client-only` \
		`use_with mysql` \
		`use_with postgres postgresql` \
		`use_with sqlite` \
		`use_enable ncurses conio` \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	if use static ; then
		cd ${D}/usr/sbin
		mv static-bacula-fd bacula-fd
		mv static-bconsole bconsole
		if ! use client-only ; then
			mv static-bacula-dir bacula-dir
			mv static-bacula-sd bacula-sd
		fi
		if use gnome ; then
			mv static-gnome-console gnome-console
		fi
		cd ${S}
	fi

	if use gnome ; then
		make_desktop_entry \
			"gnome-console -c /etc/bacula/gnome-console.conf" \
			"Bacula Console" /usr/share/pixmaps/bacula.png "app-admin" \
			"/usr/sbin"
	fi

	insinto /usr/share/pixmaps
	doins scripts/bacula.png

	insinto /var/lib/bacula/update
	doins updatedb/update*

	dodoc ChangeLog README ReleaseNotes

	exeinto /etc/init.d
	newexe ${FILESDIR}/bacula-init3 bacula

	# fix init script
	if use mysql ; then
		USEDB='use mysql'
	elif use postgres ; then
		USEDB='use postgres'
	else
		USEDB=''
	fi
	sed -i -e "s:%%USE_DB%%:${USEDB}:" ${D}/etc/init.d/bacula

	insinto /etc/conf.d
	newins ${FILESDIR}/bacula-conf bacula
	if use client-only ; then
		SERVICES='fd'
	else
		SERVICES='sd fd dir'
	fi
	sed -i -e "s:%%SERVICES%%:${SERVICES}:" ${D}/etc/conf.d/bacula

	chgrp bacula ${D}/usr/sbin/*
	chgrp -R bacula ${D}/etc/bacula
}

pkg_preinst() {
	enewgroup bacula || die "problem adding group bacula"
}

pkg_postinst() {
	# the working directory
	install -m0750 -o root -g bacula -d ${ROOT}/var/bacula

	if use mysql ; then DB="mysql" ; fi
	if use postgres ; then DB="postgresql" ; fi
	if use sqlite ; then DB="sqlite" ; fi

	if ! use client-only ; then
		einfo "If this is a new install, you must create the ${DB} databases with:"
		einfo " /var/lib/bacula/create_${DB}_database"
		einfo " /var/lib/bacula/grant_${DB}_privileges"
		einfo " /var/lib/bacula/make_${DB}_tables"
		einfo
		einfo "If you're upgrading from a major release, you must upgrade your bacula database."
		einfo "Please read the manual chapter for how to upgrade your database."
		einfo "You can find database upgrade scripts on /var/lib/bacula."
		einfo
	fi
}