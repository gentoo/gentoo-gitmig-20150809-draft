# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goserver/x2goserver-2.0.1.19.ebuild,v 1.2 2009/12/05 09:11:32 ssuominen Exp $

EAPI=1
inherit versionator

MAJOR_PV="$(get_version_component_range 1-3)"
FULL_PV="${MAJOR_PV}-$(get_version_component_range 4)"
DESCRIPTION="The X2Go server"
HOMEPAGE="http://x2go.berlios.de"
SRC_URI="http://x2go.obviously-nice.de/deb/pool-lenny/${PN}/${PN}_${FULL_PV}_all.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse"

DEPEND=""
RDEPEND="app-admin/sudo
	net-misc/nx
	virtual/postgresql-server
	virtual/ssh
	fuse? ( sys-fs/sshfs-fuse )"
# Still in the NX overlay for now
#	ldap? ( net-misc/x2goldaptools )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"

	tar xozf data.tar.gz || die "failure unpacking data.tar.gz"

	# Use nxagent directly
	sed -i -e "s/x2goagent/nxagent/" usr/bin/x2gostartagent || die "sed failed"
}

src_install() {
	dobin usr/bin/*
	dosbin usr/sbin/*

	exeinto /usr/share/x2go/script
	doexe usr/lib/x2go/script/x2gocreatebase.sh

	insinto /etc/x2go
	doins etc/x2go/sql

	newinitd "${FILESDIR}"/${PN}.init ${PN}
}

pkg_postinst() {
	elog "To work, x2goserver needs a configured postgreSQL database"
	elog "Sample script to create the database can be found here:"
	elog "    /usr/share/x2go/script/x2gocreatebase.sh"
	einfo ""
	elog "You also need to give sudo rights on x2gopgwrapper to your users"
	elog "A sudoers example for all members of the group users:"
	elog "    %users ALL=(ALL) NOPASSWD: /usr/bin/x2gopgwrapper"
}
