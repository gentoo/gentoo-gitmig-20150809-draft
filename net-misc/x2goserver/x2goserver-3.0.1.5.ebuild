# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goserver/x2goserver-3.0.1.5.ebuild,v 1.1 2010/04/29 12:48:01 voyageur Exp $

EAPI=1
inherit eutils versionator

MAJOR_PV="$(get_version_component_range 1-3)"
FULL_PV="${MAJOR_PV}-$(get_version_component_range 4)"
DESCRIPTION="The X2Go server"
HOMEPAGE="http://x2go.berlios.de"
SRC_URI="http://x2go.obviously-nice.de/deb/pool-lenny/${PN}/${PN}_${FULL_PV}_all.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse ldap postgres sqlite"

DEPEND=""
RDEPEND="app-admin/sudo
	net-misc/nx
	virtual/ssh
	fuse? ( sys-fs/sshfs-fuse )
	postgres? ( virtual/postgresql-server )
	sqlite? ( dev-db/sqlite )"
# Still in the NX overlay for now
#	ldap? ( net-misc/x2goldaptools )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"

	tar xozf data.tar.gz || die "failure unpacking data.tar.gz"

	# Use nxagent directly
	sed -i -e "s/x2goagent/nxagent/" usr/bin/x2gostartagent || die "sed failed"

	if use sqlite ; then
		echo sqlite > etc/x2go/sql
	fi

	epatch "${FILESDIR}"/${PN}-mountdirs_no_desktop_icon.patch
}

src_install() {
	dobin usr/bin/*
	dosbin usr/sbin/*

	exeinto /usr/share/x2go/script
	doexe usr/lib/x2go/script/x2gocreatebase.sh
	doexe usr/lib/x2go/script/x2gosqlite.sh

	insinto /etc/x2go
	doins etc/x2go/sql
	doins etc/x2go/x2goserver.conf

	if use sqlite ; then
		einfo "creating x2go sqlite database directory /var/db/x2go"
		dodir /var/db/x2go
	fi

	if use postgres ; then
		newinitd "${FILESDIR}"/${PN}.init ${PN}
	fi
}

pkg_postinst() {
	if use postgres ; then
		elog "To work, x2goserver needs a configured postgreSQL database"
		elog "	echo -n local > /etc/x2go/sql"
		elog "Sample script to create the database can be found here:"
		elog "    /usr/share/x2go/script/x2gocreatebase.sh"
	fi
	if use sqlite ; then
		elog "To work, x2goserver needs a configured sqlite database"
		elog "Sample script to create the database can be found here:"
		elog "    /usr/share/x2go/script/x2gosqlite.sh"
	fi
	einfo ""
	elog "You also need to give sudo rights on x2gopgwrapper to your users"
	elog "A sudoers example for all members of the group users:"
	elog "    %users ALL=(ALL) NOPASSWD: /usr/bin/x2gopgwrapper"
	elog "To give only a special group access to the x2goserver, "
	elog "change %users to any other group"
}
