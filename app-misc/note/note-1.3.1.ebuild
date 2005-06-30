# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/note/note-1.3.1.ebuild,v 1.1 2005/06/30 22:01:34 rphillips Exp $

inherit perl-module

DESCRIPTION="a note taking perl program"
HOMEPAGE="http://www.daemon.de/NOTE"
SRC_URI="ftp://ftp.daemon.de/scip/Apps/note/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="crypt mysql dbm"

# inherit perl-module cause depend on dev-lang/perl
DEPEND="dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Perl
	perl-core/Storable
	dev-perl/config-general
	crypt? ( dev-perl/crypt-cbc dev-perl/Crypt-Blowfish dev-perl/Crypt-DES )
	mysql? ( dev-db/mysql dev-perl/DBD-mysql )"

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"

	# Adding some basic utitily for testing note
	dodir /usr/share/${PN}
	cp ${S}/bin/stresstest.sh ${D}/usr/share/${PN}

	# Adding some help for mysql backend driver
	if use mysql; then
		dodir /usr/share/${PN}/mysql
		cp -r ${S}/mysql ${D}/usr/share/${PN}
	fi

	# Adding a sample configuration file
	dodir /etc
	cp ${S}/config/noterc ${D}/etc

	# Supressing file not needed
	for v in mysql text dbm general; do
		if ! use ${v}; then
			for u in `find ${D} -type f -name *${v}.*pm`; do
				rm ${u}
			done
		fi
	done

	dodoc README Changelog TODO UPGRADE VERSION
}

pkg_postinst()
{
	einfo ""
	einfo "Note permit you to use many backend driver for storage"
	einfo "Here, you can defined which you want install my USE flag"
	einfo "Driver available :"
	einfo "	binary		Always installed, default mode, store data in binary mode"
	einfo "	mysql		Allow to store your note in a mysql db"
	einfo "	dbm		Allow to store your note in a dbm db"
	einfo "	text		Use a serializer to store data"
	einfo "	general		Store your note in a plain-text file (Very usefull)"
	einfo ""
	einfo "So if you want to use a driver that is not in your USE flag"
	einfo "You can specify one (or many) like that :"
	einfo "	USE=\"-mysql general\" emerge note"
	einfo "or (better way)"
	einfo "	echo \"app-misc/note	-mysql general\" >> /etc/portage/package.use"
	einfo ""
	einfo "A default config file is available is /etc/noterc"
	einfo "Modify it to specify which backend you want to use and many other things"
	einfo "You can also have a per user noterc in ~/.noterc"
	einfo ""
	einfo "Have a look on /usr/share/note"
	einfo "There are many informations about mysql (if you use the USE flag mysql) backend and a stresstest script"
	einfo ""
}
