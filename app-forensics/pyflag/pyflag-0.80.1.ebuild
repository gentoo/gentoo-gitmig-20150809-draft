# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/pyflag/pyflag-0.80.1.ebuild,v 1.2 2006/02/15 20:53:18 jokey Exp $

inherit eutils autotools

DESCRIPTION="Tool for analysing log files, tcpdump files and hard disk images"
HOMEPAGE="http://pyflag.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
COMMON_DEPEND="
		net-libs/libpcap
		sys-apps/file
		dev-python/mysql-python
		sys-libs/zlib
		app-antivirus/clamav
		>=app-forensics/sleuthkit-2.03
		dev-python/pexpect
		dev-python/imaging
		media-libs/ploticus"

RDEPEND="${COMMON_DEPEND}
		dev-db/mysql"

DEPEND=">=dev-lang/swig-1.3
		${COMMON_DEPEND}"

#
# TODO: init scripts
#
#		dev-python/pexpect
#		dev-python/imaging
#		media-libs/ploticus
#		app-forensics/sleuthkit to RDEPEND as it realy only checks they are
#		installed
#

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-nodbtool.patch"
	cd "${S}"
	AT_M4DIR="config" eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die
	# don't include pyflag use include files - its just silly
	rm -rf "${D}/usr/include"

	#maybe later
	#newinitd "${FILESDIR}/${P}-init"  pyflag
	#newconfd "${FILESDIR}/${P}-conf"  pyflag
}

pkg_postinst() {
	einfo "Optionally enter database details in /etc/pyflagrc"
	einfo
	einfo "To start PyFlag just run \"pyflag\" as a normal user"
	einfo "then open your web browser on http://localhost:8000"
	einfo
	einfo "To create a database user \"emerge --config =${PF}\""
}

pkg_config() {
	ewarn "This creates the approprate adminstrative user for pyflag"
	ewarn "Run pyflag with the entered credentials to create the"
	ewarn "tables and database."
	einfo
	einfo "Enter user to create:"
	read USER
	einfo "Enter user's password:"
	read PASSWORD

	# note - poor privledge separation is used in pyflag
	# recommend not sharing with other security consious databases.
	# it may be possible to imporve this a bit using manual permission setting.
	einfo "Enter mysql root database password:"
	echo GRANT ALL PRIVILEGES ON "*.*" TO $USER@localhost \
		IDENTIFIED BY \"$PASSWORD\"\; FLUSH PRIVILEGES\;  \
		| /usr/bin/mysql -u root -p

	einfo "Do you want this data to be used for all users (y/n)?"
	ewarn "Warning - all credentials will be in a world readable file"
	ewarn "This overwrites settings in ${ROOT}/etc/pyflagrc"
	read  GLOBAL
	if [ "${GLOBAL}" == "y" ] || [ "${GLOBAL}" == "Y" ]; then
		einfo "updating global settings"
		sed -i -e "s:PYFLAG_DBUSER=.*:PYFLAG_DBUSER=$USER:" \
				-e "s:PYFLAG_DBPASSWD=.*:PYFLAG_DBPASSWD=$PASSWORD:" \
				"${ROOT}/etc/pyflagrc"
	fi
}
